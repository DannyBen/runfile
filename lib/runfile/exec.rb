require 'singleton'

module Runfile

  # This class provides methods for easily and politely run shell commands
  # through a Runfile action.
  # It is mainly a convenient wrapper around `system` and `exec` and it also
  # adds functions for running background tasks with ease.
  class ExecHandler
    include Singleton

    # Run a command, wait until it is done and continue
    def run(cmd)
      cmd = @before_run_block.call(cmd) if @before_run_block
      return false unless cmd
      say "!txtgrn!> #{cmd}" unless Runfile.quiet
      system cmd
      @after_run_block.call(cmd) if @after_run_block
    end

    # Run a command, wait until it is done, then exit
    def run!(cmd)
      cmd = @before_run_block.call(cmd) if @before_run_block
      return false unless cmd
      say "!txtgrn!> #{cmd}" unless Runfile.quiet
      exec cmd
    end

    # Run a command in the background, optionally log to a log file and save
    # the process ID in a pid file
    def run_bg(cmd, pid: nil, log: '/dev/null')
      cmd = @before_run_block.call(cmd) if @before_run_block
      return false unless cmd
      full_cmd = "exec #{cmd} >#{log} 2>&1"
      say "!txtgrn!> #{full_cmd}" unless Runfile.quiet
      process = IO.popen "exec #{cmd} >#{log} 2>&1"
      File.write pidfile(pid), process.pid if pid
      @after_run_block.call(cmd) if @after_run_block
      return process.pid
    end

    # Stop a command started with 'run_bg'. Provide the name of he pid file you 
    # used in 'run_bg'
    def stop_bg(pid)
      file = pidfile(pid)
      if File.exist? file
        pid = File.read file
        File.delete file
        run "kill -s TERM #{pid}"
      else
        say "!txtred!PID file not found." unless Runfile.quiet
      end
    end

    # Set a block to be called before each run
    def before_run(&block)
      @before_run_block = block
    end

    # Set a block to be called after each run
    def after_run(&block)
      @after_run_block = block
    end

    private

    def pid_dir
      defined?(Runfile.pid_dir) ? Runfile.pid_dir : nil
    end

    def pidfile(pid)
      pid_dir ? "#{pid_dir}/#{pid}.pid" : "#{pid}.pid"
    end

  end
end