require 'docopt'
require 'colones'

module Run
	include Colones
	class Runner
		attr_writer :last_usage, :last_help, :version, :summary

		def initialize
			@last_usage = nil
			@last_help = nil
			@actions = {}
			@options = {}
			@version = "0.0.0"
			@summary = false
		end

		def add_action(name, &block)
			@actions[name] = Action.new(block, @last_usage, @last_help)
			@last_usage = nil
			@last_help = nil
		end

		def add_option(flag, text)
			@options[flag] = text
		end

		def run(*argv)
			action = argv[0]
			action and action = action.to_sym
			begin
				args = Docopt::docopt(docopt, version: @version, argv:argv)
			 	@actions.has_key? action or abort "Runfile error: Action :#{action} is not defined"
				@actions[action].execute args
			rescue Docopt::Exit => e
				puts e.message
			end
		end

		private

		def docopt
			width, height = detect_terminal_size
			doc = "Runfile #{@version}\n"
			doc += "#{@summary} \n" if @summary
			doc += "\nUsage:\n";
			@actions.each do |name, action|
				doc += "  run #{action.usage}"
			end
			doc += "\n  run (-h | --help | --version)"
			caption_printed = false
			@actions.each do |name, action|
				action.help or next
				doc += "\n\nCommands:\n" unless caption_printed
				caption_printed = true
				helpline = "      #{action.help}"
				wrapped  = word_wrap helpline, width
				doc += "  #{action.usage}\n#{wrapped}\n\n"
			end
			doc += "Options:\n"
			doc += "  -h --help\n      Show this screen\n\n"
			doc += "  --version\n      Show version\n\n"
			@options.each do |flag, text|
				helpline = "      #{text}"
				wrapped  = word_wrap helpline, width
				doc += "  #{flag}\n#{wrapped}\n\n"
			end
			doc
		end
	end
end
