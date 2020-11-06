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

    # Run a command, wait until it is done and continue
    #   run 'rails server'
    def run(cmd)
      ExecHandler.instance.run cmd
    end

    # Run a command, wait until it is done, then exit
    #   run! 'rails server'
    def run!(cmd)
      ExecHandler.instance.run! cmd
    end

    # Run a command in the background, optionally log to a log file and save
    # the process ID in a pid file
    #   run_bg 'rails server', pid: 'rails', log: 'tmp/log.log'
    def run_bg(cmd, pid: nil, log: '/dev/null')
      ExecHandler.instance.run_bg cmd, pid: pid, log: log
    end

    # Stop a command started with 'run_bg'. Provide the name of he pid file you 
    # used in 'run_bg'
    #   stop_bg 'rails'
    def stop_bg(pid)
      ExecHandler.instance.stop_bg pid
    end

    # Set a block to be called before each run. The block should return
    # the command to run, since this is intended to let the block modify
    # the command if it needs to.
    #   before_run do |command|
    #     puts "BEFORE #{command}"
    #     command
    #   end
    def before_run(&block)
      ExecHandler.instance.before_run(&block)
    end

    # Set a block to be called after each run
    #   before_run do |command|
    #     puts "AFTER #{command}"
    #   end
    def after_run(&block)
      ExecHandler.instance.after_run(&block)
    end

    # Also allow to use 'endcommand' instead of 'command' to end
    # a command namespace definition
    alias_method :endcommand, :command
  end
end