module Runfile
  module DSL
    # Commands

    attr_reader :default_action

    def action(name = nil, shortcut = nil, &block)
      current_action.block = block
      current_action.name = name.to_s
      current_action.shortcut = shortcut.to_s if shortcut
      current_action.host = self
      finalize_current_action name.to_s
    end

    def env_var(name, help)
      env_vars[name] = help
    end

    def example(text)
      examples.push text
    end

    def help(message)
      current_action.help = message
    end

    def helpers(&block)
      helper_blocks.push block if block
      helper_blocks
    end

    def import(pathspec, context = nil)
      imports[pathspec] = context
    end

    def import_gem(pathspec, context = nil)
      gem_name, glob = pathspec.split('/', 2)
      glob ||= '*'
      path = GemFinder.find gem_name, glob
      imports[path] = context
    end

    def option(name, help)
      options[name] = help
    end

    def param(name, help)
      params[name] = help
    end

    def require_context(varname, default: nil)
      required_contexts[varname] = default
    end

    def required_contexts
      @required_contexts ||= {}
    end

    def shortcut(name)
      current_action.shortcut = name.to_s
    end

    def summary(text = nil)
      return @summary unless text

      @summary = text
    end

    def title(text = nil)
      return @title unless text

      @title = text
    end

    def usage(message)
      message = "#{name} #{message}" if name
      message = "#{host.full_name} #{message}".strip if host
      current_action.usages.push message
    end

    def version(text = nil)
      return @version unless text

      @version = text
    end

    # Evaluation Artifacts

    def actions
      @actions ||= {}
    end

    def params
      @params ||= {}
    end

    def env_vars
      @env_vars ||= {}
    end

    def examples
      @examples ||= []
    end

    def helper_blocks
      @helper_blocks ||= []
    end

    def options
      @options ||= {}
    end

    def imports
      @imports ||= {}
    end

  private

    def finalize_current_action(name)
      key = name.empty? ? :default : name
      actions[key] = current_action
      @default_action = current_action unless name
      @current_action = nil
    end

    def current_action
      @current_action ||= Action.new
    end
  end
end
