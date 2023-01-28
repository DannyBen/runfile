module Runfile
  # Represents a single action inside a {Userfile} and executes its block
  # on demand. Properties of this class are populated by the {DSL} module when
  # running a {Userfile}.
  class Action
    include Inspectable

    attr_reader :name, :shortcut
    attr_accessor :block, :help, :host

    def command_string
      result = names.join(', ')
      result.empty? ? '(default)' : result
    end

    def implicit_usages
      usages.empty? ? [usage_string] : usages
    end

    def inspectable
      { name: name, prefix: prefix, 'host.path': host&.path }
    end

    def run(args = {})
      validate_context

      instance_eval do
        host.helpers.each { |b| b.call args }
        block.call args if block
      end
    end

    def name=(value)
      @name = value&.to_s
    end

    def names
      name ? [name, shortcut].compact : ['(default)']
    end

    def prefix
      host&.full_name
    end

    def shortcut=(value)
      @shortcut = value&.to_s
    end

    def usage_string
      @usage_string ||= if shortcut
        "#{prefix} (#{name} | #{shortcut})".strip
      else
        "#{prefix} #{name}".strip
      end
    end

    def usages
      @usages ||= []
    end

    def validate_context
      host.required_contexts.each do |varname, default|
        next if host.context[varname]
        raise UserError, "Need #{varname}" if default.nil?

        host.context[varname] = default
      end
    end
  end
end
