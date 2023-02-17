module Runfile
  # All exceptions are rescued in bin/run, but using different styling
  # Note that UserError types are displayed without location and are intended
  # to be used when location is not important.

  class Error < StandardError; end
  class UserError < Error; end

  class ExitWithUsage < Error
    attr_reader :exit_code

    def initialize(message = '', exit_code: nil)
      @exit_code = exit_code || 1
      super message
    end
  end

  class ActionNotFound < UserError; end
  class GemNotFound < UserError; end
  class SyntaxError < UserError; end
  class DocoptError < SyntaxError; end
end
