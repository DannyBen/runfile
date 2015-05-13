require 'docopt'
require 'colones'

module Run
	include Colones
	class DocoptMaker
		def initialize(version, summary, actions, options)
			@version = version
			@summary = summary
			@actions = actions
			@options = options
		end

		def make
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
