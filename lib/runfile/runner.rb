module Runfile
  # Executes docopt.
  class Runner
    class << self
      def run(docopt, version: nil, argv: nil)
        args = call_docopt docopt, argv: argv, version: version
        yield args if block_given?
        args
      end

    private

      def call_docopt(docopt, version: nil, argv: nil)
        Docopt.docopt docopt, argv: argv, version: version
      rescue Docopt::Exit => e
        raise ExitWithUsage, e.message
      end
    end
  end
end
