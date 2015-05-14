module Runfile
	class Action
		attr :usage, :help

		def initialize(block, usage, help)
			@usage = usage
			@help  = help
			@block = block
		end

		def execute(args)
			@block.yield args
		end
	end
end