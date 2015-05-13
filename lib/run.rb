#!/usr/bin/env ruby
require 'docopt'
require 'colones'

module Run
	include Colones

	class Action
		attr :usage, :help

		def initialize(block, usage, help)
			@usage = usage
			@help  = help
			@block = block
		end

		def execute(args)
			@block.yield args
		end
	end

	class Runner
		attr_writer :last_usage, :last_help, :version, :summary

		def initialize
			@last_usage = nil
			@last_help = nil
			@actions = {}
			@version = "0.0.0"
			@summary = false
		end

		def add_action(name, &block)
			@actions[name] = Action.new(block, @last_usage, @last_help)
			@last_usage = nil
			@last_help = nil
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
			doc += "\n\n"
			doc += "Commands:\n"
			@actions.each do |name, action|
				helpline = "      #{action.help}"
				wrapped  = word_wrap helpline, width
				doc += "  #{action.usage}\n#{wrapped}"
			end
			doc += "\n\n"
			doc += "Options:\n"
			doc += "  -h --help  :\n      Show this screen\n\n"
			doc += "  --version  :\n      Show version\n\n"
			doc
		end
	end
	
	def version(ver)
		@runner.version = ver
	end

	def usage(text)
		@runner.last_usage = text
	end

	def help(text)
		@runner.last_help = text
	end

	def action(name, &block) 
		@runner.add_action name, &block
	end

	def summary(text)
		@runner.summary = text
	end
end

include Run
@runner = Runner.new

abort "Runfile not found" unless File.exist? 'Runfile'
load 'Runfile'

@runner.run *ARGV

