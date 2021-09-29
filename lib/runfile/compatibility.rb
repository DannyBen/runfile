# This file provides a compatibility layer for version 0.12.0 so that
# all the Colsole methods (say, resay...) and ExecHandler methods
# (run, run_bg...) are still available
# Simply require 'runfile/compatibility' to have the same functionality
# as older versions.
#
# Notes:
# - You need to have the colsole gem installed
# - Requiring this file also includes it (see the end of the file).
# - This functinality will be removed in future versions
# - More info: https://github.com/DannyBen/runfile/pull/46
require 'colsole'

module Runfile
  module Compatibilty
    include Colsole

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

include Runfile::Compatibilty
