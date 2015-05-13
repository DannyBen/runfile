#!/usr/bin/env ruby
require "docopt"

module Run
	class Action
		attr :usage

		def initialize(block, usage)
			@usage = usage
			@block = block
		end

		def execute(args)
			@block.yield args
		end
	end

	class Runner
		@@last_usage = nil
		@@actions = {}
		@@version = "0.0.0"
		@@summary = false

		def self.last_usage=(text)
			@@last_usage = text
		end

		def self.add_action(name, &block)
			@@actions[name] = Action.new(block, @@last_usage)
			@@last_usage = nil
		end

		def self.version=(ver)
			@@version = ver
		end

		def self.summary=(text)
			@@summary = text
		end

		def self.run(*argv)
			action = argv[0]
			doc = prepare_doc
			begin
				args = Docopt::docopt(doc, version: @@version, argv:argv)
				# send(ARGV[0], args)
				@@actions[action.to_sym].execute args
			rescue Docopt::Exit => e
				puts e.message
			end
		end

		private

		def self.prepare_doc
			doc = "Runfile\n#{@@summary}\n\nUsage:\n";
			@@actions.each do |name, action|
				doc += "  run #{action.usage}"
			end
			doc += "\n\n"
			doc += "Options:\n  -h --help  :\n      Show this screen"
			doc += " --version  :\n      Show version"
			doc
		end
	end

	def version(ver)
		Runner.version = ver
	end

	def usage(text)
		Runner.last_usage = text
	end

	# def help(text)
	# 	Runner.last_help = text
	# end

	def action(name, &block) 
		Runner.add_action name, &block
	end

	def summary(text)
		Runner.summary = text
	end

end
self.extend Run

load 'Runfile'

Run::Runner.run *ARGV
