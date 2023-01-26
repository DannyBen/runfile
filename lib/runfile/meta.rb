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

    def globs
      @globs ||= (masterfile ? ['*'] + masterfile.imports.keys : ['*'])
    end

    def external_files
      @external_files ||= begin
        result = []
        globs.each do |glob|
          Dir["#{glob}.runfile"].sort.each do |file|
            userfile = Userfile.load_file(file)
            userfile.context = masterfile.imports[glob] if masterfile
            result.push userfile
          end
        end
        
        result.to_h { |file| [file.name, file] }
      end
    end
  end
end
