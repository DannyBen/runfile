require 'shellwords'

module Runfile
  # Represents a single runfile.
  class Userfile
    include Renderable
    include Inspectable
    include DSL

    attr_reader :code, :name, :path
    attr_writer :context
    alias action_prefix name

    class << self
      def load_file(path)
        if masterfile? path
          name = nil
        else
          name = File.basename path, '.runfile'
          path = "#{path}.runfile" unless path.end_with? '.runfile'
        end

        code = File.read path
        new code, name: name, path: path
      end

      def masterfile?(path)
        Meta::MASTERFILE_NAMES.include? path
      end
    end

    def initialize(code = nil, name: nil, path: nil)
      @code = code
      @name = name
      @path = path

      return unless @code

      if path
        instance_eval @code, @path
      else
        instance_eval @code
      end
    end

    def inspectable
      { name: name, path: path }
    end

    def run(argv = [])
      found_delegate = delegate argv[0]
      if found_delegate
        found_delegate.run argv
      else
        run_local argv
      end
    end

    def context
      @context ||= {}
    end

    def implicit_title
      title || name
    end

    # Returns an array of actions that have help defined
    def commands
      actions.values.select(&:help)
    end

    def delegates
      @delegates ||= (name ? {} : meta.external_files)
    end

  private

    def find_action(args)
      acts = actions.values
      acts.find { |a| args[a.name] } ||
        acts.find { |a| args[a.shortcut] } ||
        acts.find { |a| args[a.prefix] } ||
        actions[:default]
    end

    def run_local(argv)
      Runner.run docopt, argv: argv, version: version do |args|
        action = find_action(args)
        raise ActionNotFound, 'Cannot find action. Is it properly defined?' unless action

        action.run args
      end
    end

    def delegate(name)
      return nil unless delegates.has_key? name

      result = delegates[name]
      result.context = contexts[name]
      result
    end

    def meta
      @meta ||= Meta.new
    end

    def docopt
      @docopt ||= render 'userfile', context: self
    end
  end
end
