module Runfile
  module DSL
    # Commands

    attr_reader :default_action

    def action(name = nil, shortcut = nil, &block)
      current_action.block = block
      current_action.name = name
      current_action.shortcut = shortcut if shortcut
      current_action.prefix = action_prefix if action_prefix
      current_action.helpers = helper_blocks if helper_blocks.any?
      finalize_current_action name
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

    def shortcut(name)
      current_action.shortcut = name
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
      message = "#{action_prefix} #{message}" if action_prefix
      current_action.usages.push message
    end

    def version(text = nil)
      return @version unless text

      @version = text
    end

    def execute(command_line)
      run Shellwords.split(command_line)
    end

    # Evaluation Artifacts

    def action_prefix
      nil
    end

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
      actions[name || :default] = current_action
      @default_action = current_action unless name
      @current_action = nil
    end

    def current_action
      @current_action ||= Action.new
    end
  end
end
