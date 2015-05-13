require 'docopt'

module Run
	class Runner
		attr_writer :last_usage, :last_help, :version, :summary

		@@instance = nil

		def initialize
			@last_usage = nil
			@last_help = nil
			@actions = {}
			@options = {}
			@version = "0.0.0"
			@summary = false
		end

		def self.instance
			@@instance = self.new if @@instance.nil?
			@@instance
		end

		def execute(argv)
			File.exist? 'Runfile' or abort "Runfile not found"
			load 'Runfile'
			@@instance.run *argv
		end

		def add_action(name, &block)
			@actions[name] = Action.new(block, @last_usage, @last_help)
			@last_usage = nil
			@last_help = nil
		end

		def add_option(flag, text)
			@options[flag] = text
		end

		def run(*argv)
			action = argv[0]
			action and action = action.to_sym
			begin
				args = Docopt::docopt(docopt, version: @version, argv:argv)
			 	@actions.has_key? action or abort "Runfile error: Action :#{action} is not defined"
				@actions[action].execute args
			rescue Docopt::Exit => e
				puts e.message
			end
		end

		private

		def docopt
			maker = DocoptMaker.new(@version, @summary, @actions, @options)
			maker.make
		end
	end
end
