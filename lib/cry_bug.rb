# frozen_string_literal: true


require 'pry'
require 'pry-stack_explorer'
require 'pry-doc'
require 'pry-rescue' # TODO: FIXME: solve the version compatibility issue
require 'amazing_print'
require 'clipboard'
require 'binding_of_caller'
require 'readline'

# Force Vi/Vim keybindings system-wide inside the engine console
begin
  Readline.vi_editing_mode
rescue StandardError
  nil
end

# do stuff for pry-rescue
if defined?(Minitest) || ENV['RACK_ENV'] == 'test'
  begin
    # 1. Stub the deleted MiniTest / Minitest::Unit namespaces
    module MiniTest
      Unit = Minitest
    end

    module Minitest
      Unit = Minitest
    end

    class MiniTest::Unit::TestCase < Minitest::Test # rubocop:disable Style/OneClassPerFile,Style/ClassAndModuleChildren
      # Aliases the old class name for legacy plugin checks
    end

    # 2. Stub the deleted run_one_method hook onto Minitest::Runnable
    class << Minitest::Runnable
      # Old plugins often do: alias_method :old_run_one_method, :run_one_method
      # or define it directly on the singleton class.
      def run_one_method(klass, method_name, reporter)
        # Forward to the Minitest 6 instance-level runner.
        # We instantiate the test class and invoke its modern `run` method.
        instance = klass.new(method_name)
        instance.run(reporter)
      end
    end
    require 'pry-rescue/minitest'
  rescue LoadError
    # Silently ignore if pry-rescue isn't in the project's bundle
  end
end

# Configure persistent shell history locations across terminals
Pry.config.history_file = File.expand_path('~/.cry_history')

# Configure Amazing Print as the core pretty-printing engine
AmazingPrint.defaults = { indent: 2, sort_keys: true }
Pry.config.print = proc { |output, value| output.puts value.ai }

# Inject breakpoint shortcut commands into the global execution space
module Kernel
  def cry
    binding.of_caller(1).pry
  end

  def ry
    binding.of_caller(1).pry
  end
end


