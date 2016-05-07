# This file defines all the commands supported in a Runfile.
# All commands are immediately handed over to the Runner instance
# for handling.

# Smells of :reek:UtilityFunction
module Runfile
  # Set the name of your Runfile program
  def name(name)
    Runner.instance.name = name
  end

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
  def option(flag, text, scope=nil)
    Runner.instance.add_option flag, text, scope
  end

  # Set an example command (can be called multiple times)
  def example(text)
    Runner.instance.add_example text
  end

  # Define the action
  def action(name, altname=nil, &block) 
    Runner.instance.add_action name, altname, &block
  end

  # Define a new command namespace
  def command(name=nil)
    Runner.instance.namespace = name
  end

  # Cross-call another action
  def call(command_string)
    Runner.instance.cross_call command_string
  end

  # Run a command, wait until it is done and continue
  def run(*args)
    ExecHandler.instance.run *args
  end

  # Run a command, wait until it is done, then exit
  def run!(*args)
    ExecHandler.instance.run! *args
  end

  # Run a command in the background, optionally log to a log file and save
  # the process ID in a pid file
  def run_bg(*args)
    ExecHandler.instance.run_bg *args
  end

  # Stop a command started with 'run_bg'. Provide the name of he pid file you 
  # used in 'run_bg'
  def stop_bg(*args)
    ExecHandler.instance.stop_bg *args
  end

  # Set a block to be called before each run
  def before_run(&block)
    ExecHandler.instance.before_run &block
  end

  # Set a block to be called after each run
  def after_run(&block)
    ExecHandler.instance.after_run &block
  end

  # Also allow to use 'endcommand' instead of 'command' to end
  # a command namespace definition
  alias_method :endcommand, :command
end
