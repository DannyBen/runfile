module Runfile

  module DSL
    # The name 'name' was causing some issues in some debugging sessions 
    # with pry and some other issues. It is replaced with 'title'
    def name(name=nil)
      say! "!txtred!You are using the deprecated directive 'name' in your Runfile.\nUse 'title' instead"
      Runner.instance.name = name if name
    end
  end
end