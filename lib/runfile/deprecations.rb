module Runfile

  module DSL
    # The name 'name' was causing some issues in some debugging sessions 
    # with pry and some other issues. It is replaced with 'title'
    def name(name=nil)
      say! "!txtred!Warning:\n  You are using the deprecated directive 'name' in your Runfile.\n  Use 'title' instead.\n"
      Runner.instance.name = name if name
    end
  end
end