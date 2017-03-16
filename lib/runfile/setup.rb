module Runfile
  class << self
    # Set the directory where PID files are stored when using `run_bg`
    #   Runfile.pid_dir = 'tmp'
    attr_accessor :pid_dir

    # Disable echoing of the command when using `run` or `run!`
    #   Runfile.quiet = true
    attr_accessor :quiet

    # You can also configure Runfile by providing a block:
    #  Runfile.setup do |config|
    #    config.quiet = true
    #  end
    def setup
      yield self
    end
  end
end