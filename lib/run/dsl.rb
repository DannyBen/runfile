module Run
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

	def option(flag, text)
		@runner.add_option flag, text
	end
end
