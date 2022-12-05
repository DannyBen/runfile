require 'fileutils'

module Runfile
  # Creates a new runfile when running +run new+ in a directory without
  # runfiles.
  class Initiator
    include Inspectable
    include Renderable

    def run(argv = ARGV)
      Runner.run docopt, argv: argv, version: VERSION do |args|
        execute_command args
      end
    end

  private

    def execute_command(args)
      return create_new_file if args['new']

      if args['NAME']
        create_example args['NAME']
      else
        list_examples
      end
    end

    def create_new_file
      template = File.expand_path 'templates/runfile', __dir__
      FileUtils.cp template, '.'
      say 'Created g`runfile`'
      say_tip
    end

    def list_examples
      say "nu`Available Examples`\n"
      examples.each { |x| puts "  #{x}" }
      say ''
      say <<~TIP
        Run g`run example EXAMPLE` with any of these examples to copy the files
        to the current directory.

        If you are not sure, try g`run example naval-fate`.
      TIP
    end

    def create_example(name)
      dir = "#{examples_dir}/#{name}"
      files = Dir["#{dir}/{runfile,*.runfile,*.rb}"]
      raise UserError, "No such example: nu`#{name}`" if files.empty?

      files.each { |file| safe_copy file }
      say_tip
    end

    def say_tip
      say ''
      say 'Run g`run` or g`run --help` to see your runfile'
      say 'Delete the copied files to go back to the initial state'
    end

    def safe_copy(file)
      target = File.basename file
      # This will never happen since if there is a runfile, the initiator will
      # not be called. Nonetheless, keep it for safety
      return if File.exist? target

      FileUtils.cp file, '.'
      say "Copied g`#{target}`"
    end

    def examples
      @examples ||= Dir["#{examples_dir}/*"]
        .select { |f| File.directory?  f }
        .map { |f| File.basename f }
    end

    def examples_dir
      @examples_dir ||= File.expand_path '../../examples', __dir__
    end

    def docopt
      @docopt ||= render('initiator', context: self)
    end
  end
end
