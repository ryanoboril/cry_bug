require 'pry'
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

# Configure persistent shell history locations across terminals
Pry.config.history.file = File.expand_p("~/.cry_history")

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
