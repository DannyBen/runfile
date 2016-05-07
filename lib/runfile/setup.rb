module Runfile
  class << self
    attr_accessor :pid_dir, :quiet

    def setup
      yield self
    end
  end
end