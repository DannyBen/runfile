require 'shellwords'

module Runfile
  # Represents a single runfile.
  class Userfile
    include Renderable
    include Inspectable
    include DSL

    attr_reader :path, :host
    attr_accessor :context

    def initialize(path, context: nil, host: nil)
      @path = path
      @host = host
      @context = context || {}
    end

    def basename
      @basename ||= File.basename(path, '.runfile')
    end

    def code
      @code ||= File.read(path)
    end

    def commands
      actions.values.select(&:help)
    end

    def eval_code
      return if evaluated?

      @evaluated = true
      instance_eval code, path
    end

    def evaluated?
      @evaluated
    end

    def full_name
      id.join ' '
    end

    def guests
      @guests ||= begin
        result = imports.map do |glob, context|
          Dir.glob("#{glob}.runfile").sort.map do |guest_path|
            Userfile.new guest_path, context: context, host: self
          end
        end

        result.flatten
      end
    end

    def id
      if host
        (host.id + [name]).compact
      else
        [name].compact
      end
    end

    def inspectable
      { name: name, path: path }
    end

    def name
      @name ||= (rootfile? ? nil : basename.downcase)
    end

    def rootfile?
      basename.casecmp? 'runfile'
    end

    def run(argv = [])
      eval_code
      argv = transform_argv argv if argv.any?

      found_guest = find_guest argv

      if found_guest
        found_guest.run argv
      else
        run_local argv
      end
    end

  private

    def docopt
      @docopt ||= render 'userfile', context: self
    end

    def find_action(args)
      acts = actions.values
      acts.find { |a| args[a.name] } ||
        acts.find { |a| args[a.shortcut] } ||
        acts.find { |a| args[a.prefix] } ||
        actions[:default]
    end

    def find_guest(argv)
      guests.find do |guest|
        guest_id_size = guest.id.size
        next if guest_id_size.zero?

        argv.first(guest_id_size) == guest.id
      end
    end

    def run_local(argv)
      exit_code = nil
      # This is here to allow guests to provide their own title/summary as
      # the help message for the Commands block.
      # TODO: Relatively costly. Consider alternatives.
      guests.each(&:eval_code)

      Runner.run docopt, argv: argv, version: version do |args|
        action = find_action(args)
        raise ActionNotFound, 'Cannot find action. Is it properly defined?' unless action

        exit_code = action.run args
      end

      exit_code if exit_code.is_a? Integer
    end

    def transform_argv(argv)
      transforms.each do |from, to|
        return Shellwords.split(to) + argv[1..] if from == argv[0]
      end

      argv
    end
  end
end
