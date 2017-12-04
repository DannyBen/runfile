require 'docopt'
require 'colsole'

module Runfile
  # The DocoptHelper class handles the dynamic generation of the 
  # docopt document and the docopt part of the execution (meaning,
  # to call Docopt so it returns the parsed arguments or halts with
  # usage message).
  class DocoptHelper
    include Colsole

    # The constructor expects to an object that responds to all the 
    # textual details needed to generate a docopt document (name, version, 
    # summary, options) and an array of Action objects.
    # The superspace argument will be the name of runfile, in case we
    # are running a named.runfile. It is only needed to generate the 
    # proper `run superspace (-h|--help|--version)` line
    def initialize(options)
      @superspace = options.superspace
      @name       = options.name
      @version    = options.version
      @summary    = options.summary
      @actions    = options.actions
      @options    = options.options
      @examples   = options.examples
    end

    # Generate a document based on all the actions, help messages
    # and options we have collected from the Runfile DSL.
    def docopt
      width = detect_terminal_size[0]
      doc = []
      doc << (@version ? "#{@name} #{@version}" : "#{@name}")
      doc << "#{@summary}" if @summary
      doc += docopt_usage
      doc += docopt_commands width
      doc += docopt_options width
      doc += docopt_examples width
      doc.join "\n"
    end

    # Return all docopt lines for the 'Usage' section
    def docopt_usage 
      doc = ["\nUsage:"];
      @actions.each do |_name, action|
        doc << "  run #{action.usage}" unless action.usage == false
      end
      basic_flags = @version ? "(-h|--help|--version)" : "(-h|--help)"
      if @superspace
        doc << "  run #{@superspace} #{basic_flags}\n"
      else
        doc << "  run #{basic_flags}\n"
      end
      doc
    end

    # Return all docopt lines for the 'Commands' section
    def docopt_commands(width)
      doc = []
      caption_printed = false
      @actions.each do |_name, action|
        action.help or next
        doc << "Commands:" unless caption_printed
        caption_printed = true
        helpline = "      #{action.help}"
        wrapped  = word_wrap helpline, width
        doc << "  #{action.usage}\n#{wrapped}\n" unless action.usage == false
      end
      doc
    end

    # Return all docopt lines for the various 'Options' sections
    def docopt_options(width)
      @options['Options'] = {} unless @options['Options']
      @options['Options']['-h --help'] = 'Show this screen'
      @options['Options']['--version'] = 'Show version number' if @version

      doc = []
      @options.each do |scope, values|
        doc << "#{scope}:"
        values.each do |flag, text|
          helpline = "      #{text}"
          wrapped  = word_wrap helpline, width
          doc << "  #{flag}\n#{wrapped}\n"
        end
      end
      doc
    end

    # Return all docopt lines for the 'Examples' section
    def docopt_examples(width)
      return [] if @examples.empty?

      doc = ["Examples:"]
      base_command = @superspace ? "run #{@superspace}" : "run"
      @examples.each do |command|
        helpline = "  #{base_command} #{command}"
        wrapped  = word_wrap helpline, width
        doc << "#{wrapped}"
      end
      doc
    end

    # Call the docopt handler, which will either return a parsed
    # arguments list, or halt execution and show usage.
    def args(argv)
      Docopt.docopt(docopt, version: @version, argv:argv)
    end
  end
end
