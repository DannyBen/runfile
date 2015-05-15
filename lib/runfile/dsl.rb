# This file defines all the commands supported in a Runfile.
# All commands are immediately handed over to the Runner instance
# for handling.

module Runfile

	# Set the version of your Runfile program
	def version(ver)
		Runner.instance.version = ver
	end

	# Set the one line summary of your Runfile program
	def summary(text)
		Runner.instance.summary = text
	end

	# Set the usage pattern for the next action
	def usage(text)
		Runner.instance.last_usage = text
	end

	# Set the help message for the next action
	def help(text)
		Runner.instance.last_help = text
	end

	# Add an option/flag to the next action (can be called multiple
	# times)
	def option(flag, text)
		Runner.instance.add_option flag, text
	end

	# Define the action
	def action(name, &block) 
		Runner.instance.add_action name, &block
	end

	# Define a new command namespace
	def command(name=nil)
		Runner.instance.namespace = name
	end

	# Cross-call another action
	def call(command_string)
		Runner.instance.cross_call command_string
	end
end
