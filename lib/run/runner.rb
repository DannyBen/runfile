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
			begin
				args = Docopt::docopt(docopt, version: @version, argv:argv)
				@actions[action.to_sym].execute args
			rescue Docopt::Exit => e
				puts e.message
			# rescue NoMethodError => e
			# 	abort "Runfile does contain this action: #{action}"
			end
		end

		private

		def docopt
			width, height = detect_terminal_size
			doc = "Runfile #{@version}\n#{@summary} \n\nUsage:\n";
			@actions.each do |name, action|
				doc += "  run #{action.usage}"
			end
			doc += "\n  run (-h | --help | --version)\n\n"
			doc += "Commands:\n"
			@actions.each do |name, action|
				helpline = "      #{action.help}"
				wrapped  = word_wrap helpline, width
				doc += "  #{action.usage}\n#{wrapped}"
			end
			doc += "\n\n"
			doc += "Options:\n"
			doc += "  -h --help\n      Show this screen\n\n"
			doc += "  --version\n      Show version\n\n"
			@options.each do |flag, text|
				helpline = "      #{text}"
				wrapped  = word_wrap helpline, width
				doc += "  #{flag}\n#{wrapped}"
			end
			doc
		end
	end
end
