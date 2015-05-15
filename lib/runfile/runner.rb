require 'docopt'

module Runfile

	# The Runner class is the main workhorse behind Runfile.
	# It handles all the Runfile DSL commands and executes the Runfile.
	class Runner
		attr_accessor :last_usage, :last_help, :version, :summary, :namespace

		@@instance = nil

		# Initialize all variables to sensible defaults.
		def initialize
			@last_usage = nil
			@last_help = nil
			@namespace = nil
			@actions = {}
			@options = {}
			@version = "0.0.0"
			@summary = false
		end

		# Return a singleton Runner instance.
		def self.instance
			@@instance = self.new if @@instance.nil?
			@@instance
		end

		# Load and execute a Runfile call.
		def execute(argv)
			File.exist? 'Runfile' or handle_no_runfile argv
			load 'Runfile'
			@@instance.run *argv
		end

		# Add an action to the @actions array, and use the last known
		# usage and help messages sent by the DSL.
		def add_action(name, &block)
			@last_usage = name if @last_usage.nil?
			if @namespace 
				name = "#{namespace}_#{name}".to_sym
				@last_usage = "#{@namespace} #{@last_usage}"
			end
			@actions[name] = Action.new(block, @last_usage, @last_help)
			@last_usage = nil
			@last_help = nil
		end

		# Add an option flag and its help text.
		def add_option(flag, text)
			@options[flag] = text
		end

		# Run the command. This is a wrapper around docopt. It will 
		# generate the docopt document on the fly, using all the 
		# information collected so far.
		def run(*argv)
			action = find_action argv
			begin
				docopt_exec action, argv
			rescue Docopt::Exit => e
				puts e.message
			end
		end

		# Invoke action from another action. Used by the DSL's #call 
		# function. Expects to get a single string that looks as if
		# it was typed in the command prompt.
		def cross_call(command_string) 
			argv = command_string.split /\s(?=(?:[^"]|"[^"]*")*$)/
			action = find_action argv
			begin
				docopt_exec action, argv
			rescue Docopt::Exit => e
				puts "Cross call failed: #{command_string}"
				abort e.message
			end
		end

		private

		# Dynamically generate the docopt document.
		def docopt
			maker = DocoptMaker.new(@version, @summary, @actions, @options)
			maker.make
		end

		# Call the docopt parser and execute the action with the 
		# parsed arguments.
		# This should always be called in a begin...rescue block and
		# you should handle the Docopt::Exit exception.
		def docopt_exec(action, argv)
			args = Docopt::docopt(docopt, version: @version, argv:argv)
			action or abort "Runfile error: Action not found"
			@actions[action].execute args
		end

		# Inspect the first two arguments in the argv and look for
		# a matching action or command_action.
		# We give priority to the second form (:make_jam) in order to
		# also allow "overloading" of the command as an action 
		# (e.g. also allow a global action called :make).
		def find_action(argv)
			if argv.size >= 2
				action = "#{argv[0]}_#{argv[1]}".to_sym
				return action if @actions.has_key? action
			end
			if argv.size >= 1
				action = argv[0].to_sym
				return action if @actions.has_key? action
			end
			return false
		end

		# Handle the case when `run` is called without a Runfile 
		# present. We will let the user know they can type `run make`
		# to create a new sample Runfile.
		def handle_no_runfile(argv)
			if argv[0] == "make"
				sample = File.dirname(__FILE__) + "/../../examples/template/Runfile"
				dest   = Dir.pwd + "/Runfile"
				File.write(dest, File.read(sample))
				abort "Runfile created."
			else
				abort "Runfile not found.\nUse 'run make' to create one."
			end
		end
	end
end
