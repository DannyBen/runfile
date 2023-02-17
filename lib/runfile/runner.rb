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
        DocoptNG.docopt docopt, argv: argv, version: version
      rescue DocoptNG::Exit => e
        raise ExitWithUsage.new(exit_code: e.exit_code), e.message
      rescue DocoptNG::DocoptLanguageError => e
        raise DocoptError, "There is an error in your runfile:\nnb`#{e.message}`"
      end
    end
  end
end
