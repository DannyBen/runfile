module Runfile

  # The Action class represents a single Runfile action.
  # This object holds all the information needed to execute it and
  # show its help text (excluding the options, as they are considered
  # global throughout the application)
  class Action
    attr :usage, :help

    def initialize(block, usage, help)
      @usage = usage
      @help  = help
      @block = block
    end

    # Call the provided block
    def execute(args)
      @block.yield args
    end
  end
end