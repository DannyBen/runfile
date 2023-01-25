module Runfile
  # Holds meta information about the state of runfiles in a given directory
  class Meta
    include Inspectable

    MASTERFILE_NAMES = %w[runfile Runfile runfile.rb]

    def masterfile_path
      @masterfile_path ||= begin
        result = nil

        MASTERFILE_NAMES.each do |name|
          if File.exist? name
            result = name
            break
          end
        end

        result
      end
    end

    def handler(_argv = ARGV)
      masterfile || dummy || initiator
    end

    # If there are external files and no masterfile, we will use a dummy empty
    # runfile as a masterfile to serve as the access point to the named
    # runfiles
    def dummy
      return nil unless external_files.any?

      Userfile.new
    end

    def initiator
      Initiator.new
    end

    def masterfile
      return nil unless masterfile_path

      @masterfile ||= Userfile.load_file masterfile_path
    end

    # def title
    #   masterfile&.title
    # end

    # def summary
    #   masterfile&.summary
    # end

    def globs
      @globs ||= (masterfile ? ['*'] + masterfile.imports : ['*'])
    end

    def external_files
      @external_files ||= globs
        .map { |glob| Dir["#{glob}.runfile"].sort }
        .flatten
        .to_h { |file| [File.basename(file, '.runfile'), Userfile.load_file(file)] }
    end
  end
end
