module Runfile

  module Exec
    def self.included(base)
      say! "!txtred!Runfile::Exec is deprecated. You should change your Runfile:"
      say! "!txtred!  1. There is no need to include Runfile::Exec, it is already included."
      say! "!txtred!  2. Change any configuration from Runfile::Exec.pid_dir to Runfile.pid_dir"
      abort
    end
  end

end