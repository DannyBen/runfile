# This file defines all the commands supported in a Runfile.
# All commands are immediately handed over to the Runner instance
# for handling.

module Runfile
  module DSL
    private

    # Set the name of your Runfile program
    #   title 'My Runfile'
    def title(name)
      Runner.instance.name = name
    end

    # Set the version of your Runfile program
    #   version '0.1.0'
    def version(ver)
      Runner.instance.version = ver
    end

    # Set the one line summary of your Runfile program
    #   summary 'Utilities for my server'
    def summary(text)
      Runner.instance.summary = text
    end

    # Set the usage pattern for the next action
    #   usage 'server [--background]'
    def usage(text)
      Runner.instance.last_usage = text
    end

    # Set the help message for the next action
    #   help 'Starts the server in the foreground or background'
    def help(text)
      Runner.instance.last_help = text
    end

    # Add an option/flag to the next action (can be called multiple
    # times)
    #   option '-b --background', 'Start in the background'
    def option(flag, text, scope=nil)
      Runner.instance.add_option flag, text, scope
    end

    # Add a parameter (can be called multiple times)
    #   param 'FOLDER', 'Folder to copy'
    def param(name, text, scope=nil)
      Runner.instance.add_param name, text, scope
    end

    # Set an environment variable (can be called multiple times)
    #   env_var 'USER', 'Set the user (same as --user)'
    def env_var(name, text, scope = nil)
      Runner.instance.add_env_var name, text, scope
    end

    # Set an example command (can be called multiple times)
    #   example 'server --background'
    def example(text)
      Runner.instance.add_example text
    end

    # Define the action
    #   action :server do |args|
    #     run 'rails server'
    #   end
    def action(name, altname=nil, &block) 
      Runner.instance.add_action name, altname, &block
    end

    # Define a new command namespace
    #   command 'server'
    #   # ... define actions here
    #   endcommand
    def command(name=nil)
      Runner.instance.namespace = name
    end

    # Cross-call another action
    #   execute 'other_action'
    def execute(command_string)
      Runner.instance.cross_call command_string
    end

    # Also allow to use 'endcommand' instead of 'command' to end
    # a command namespace definition
    alias_method :endcommand, :command
  end
end