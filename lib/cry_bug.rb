# frozen_string_literal: true

require 'pry'
require 'pry-stack_explorer'
require 'pry-doc'
require 'pry-rescue'
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

# ByeBug shortcuts
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'
# end

if ENV.select { |k, _v| /(RAILS|RACK|RUBY|APP)_ENV/ === k }&.values&.first === 'test'
  # Add Minitest 6 compatibility stups to make pry-rescue work properly
  module MiniTest
    Unit = Minitest
  end

  module Minitest
    Unit = Minitest
  end

  class MiniTest::Unit::TestCase < Minitest::Test # rubocop:disable Style/ClassAndModuleChildren
    # Aliases the old class name for legacy plugin checks
  end

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
