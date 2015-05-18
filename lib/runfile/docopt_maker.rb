require 'docopt'
require 'colsole'

module Runfile
	include Colsole

	# The DocoptMaker class handles the dynamic generation of the docopt
	# document.
	class DocoptMaker
		def initialize(name, version, summary, actions, options)
			@name    = name
			@version = version
			@summary = summary
			@actions = actions
			@options = options
		end

		# Generate a document based on all the actions, help messages
		# and options we have collected from the Runfile DSL.
		def make
			width, height = detect_terminal_size
			doc = "#{@name} #{@version}\n"
			doc += "#{@summary} \n" if @summary
			doc += "\nUsage:\n";
			@actions.each do |name, action|
				doc += "  run #{action.usage}\n" unless action.usage == false
			end
			doc += "  run (-h | --help | --version)\n\n"
			caption_printed = false
			@actions.each do |name, action|
				action.help or next
				doc += "Commands:\n" unless caption_printed
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
