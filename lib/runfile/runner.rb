require 'docopt'

module Runfile

	# The Runner class is the main workhorse behind Runfile.
	# It handles all the Runfile DSL commands and executes the Runfile.
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

		# Return a singleton Runner instance
		def self.instance
			@@instance = self.new if @@instance.nil?
			@@instance
		end

		# Load and execute a Runfile call
		def execute(argv)
			File.exist? 'Runfile' or abort "Runfile not found"
			load 'Runfile'
			@@instance.run *argv
		end

		# Add an action to the @actions array, and use the last known
		# usage and help messages sent by the DSL.
		def add_action(name, &block)
			@actions[name] = Action.new(block, @last_usage, @last_help)
			@last_usage = nil
			@last_help = nil
		end

		# Add an option flag and its help text
		def add_option(flag, text)
			@options[flag] = text
		end

		# Run the command. This is a wrapper around docopt. It will 
		# generate the docopt document on the fly, using all the 
		# information collected so far.
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

		# Dynamically generate the docopt document
		def docopt
			maker = DocoptMaker.new(@version, @summary, @actions, @options)
			maker.make
		end
	end
end
