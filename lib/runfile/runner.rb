require 'docopt'
require 'pp'

module Runfile

	# The Runner class is the main workhorse behind Runfile.
	# It handles all the Runfile DSL commands and executes the Runfile.
	class Runner
		attr_accessor :last_usage, :last_help, :name, :version, 
			:summary, :namespace, :superspace

		@@instance = nil

		# Initialize all variables to sensible defaults.
		def initialize
			@superspace = nil    # used when filename != Runfile
			@last_usage = nil    # dsl: usage
			@last_help  = nil    # dsl: help
			@namespace  = nil    # dsl: #command
			@actions = {}        # dsl: action
			@options = {}        # dsl: option
			@name    = "Runfile" # dsl: name
			@version = "0.0.0"   # dsl: version
			@summary = false     # dsl: summary
		end

		# Return a singleton Runner instance.
		def self.instance
			@@instance = self.new if @@instance.nil?
			@@instance
		end

		# Load and execute a Runfile call.
		def execute(argv, filename='Runfile')
			File.file? filename or handle_no_runfile argv
			begin
				load filename
			rescue => e
				abort "Runfile error:\n#{e.message}"
			end
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
			if @superspace 
				name = "#{superspace}_#{name}".to_sym
				@last_usage = "#{@superspace} #{@last_usage}"
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
			begin
				docopt_exec argv
			rescue Docopt::Exit => e
				puts e.message
			end
		end

		# Invoke action from another action. Used by the DSL's #call 
		# function. Expects to get a single string that looks as if
		# it was typed in the command prompt.
		def cross_call(command_string) 
			argv = command_string.split /\s(?=(?:[^"]|"[^"]*")*$)/
			begin
				docopt_exec argv
			rescue Docopt::Exit => e
				puts "Cross call failed: #{command_string}"
				abort e.message
			end
		end

		private

		# Dynamically generate the docopt document.
		def docopt
			maker = DocoptMaker.new(@name, @version, @summary, @actions, @options)
			maker.make
		end

		# Call the docopt parser and execute the action with the 
		# parsed arguments.
		# This should always be called in a begin...rescue block and
		# you should handle the Docopt::Exit exception.
		def docopt_exec(argv)
			args = Docopt::docopt(docopt, version: @version, argv:argv)
			action = find_action argv
			action or abort "Runfile error: Action not found"
			@actions[action].execute args
		end

		# Inspect the first three arguments in the argv and look for
		# a matching action.
		# We will first look for a_b_c action, then for a_b and 
		# finally for a. This is intended to allow "overloading" of 
		# the command as an action (e.g. also allow a global action 
		# called 'a').
		def find_action(argv)
			3.downto(1).each do |n|
				next unless argv.size >= n 
				action = argv[0..n-1].join('_').to_sym
				return action if @actions.has_key? action
			end
			return false
		end

		# Handle the case when `run` is called without a Runfile 
		# present. We will let the user know they can type `run make`
		# to create a new sample Runfile.
		# If the first argument matches the name of a *.runfile name,
		# we will execute it.
		def handle_no_runfile(argv)
			if argv[0] == "make"
				sample = File.expand_path("../templates/Runfile", __FILE__)
				outfile = argv[1] ? "#{argv[1]}.runfile" : "Runfile"
				dest   = "#{Dir.pwd}/#{outfile}"
				File.write(dest, File.read(sample))
				abort "#{outfile} created."
			elsif argv[0] and File.exist? "#{argv[0]}.runfile"
				@superspace = argv[0]
				execute argv, "#{argv[0]}.runfile"
			else
				runfiles = Dir['*.runfile']
				runfiles.empty? and abort "Runfile engine v#{Runfile::VERSION}\n\nRunfile not found.\nUse 'run make' to create 'Runfile'.\nUse 'run make name' to create 'name.runfile'."
				runfiles.each do |f|
					f.slice! '.runfile'
					puts "Did you mean 'run #{f}'"
				end
			end
			exit
		end
	end
end
