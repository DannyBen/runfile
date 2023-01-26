module Runfile
  # Represents a single action inside a {Userfile} and executes its block
  # on demand. Properties of this class are populated by the {DSL} module when
  # running a {Userfile}.
  class Action
    include Inspectable

    attr_reader :name, :shortcut
    attr_accessor :block, :help, :host

    def run(args = {})
      instance_eval do
        host.helpers.each { |b| b.call args }
        block.call args
      end
    end

    def inspectable
      { name: name, prefix: prefix, shortcut: shortcut, host: host }
    end

    def name=(value)
      @name = value&.to_s
    end

    def shortcut=(value)
      @shortcut = value&.to_s
    end

    def full_name
      @full_name ||= if shortcut
        "#{host.name} (#{name} | #{shortcut})".strip
      else
        "#{host.name} #{name}".strip
      end
    end

    def prefix
      host&.name
    end

    def names
      name ? [name, shortcut].compact : ['(default)']
    end

    def implicit_usages
      usages.empty? ? [full_name] : usages
    end

    def usages
      @usages ||= []
    end
  end
end
