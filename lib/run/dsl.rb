module Run
	def version(ver)
		Runner.instance.version = ver
	end

	def usage(text)
		Runner.instance.last_usage = text
	end

	def help(text)
		Runner.instance.last_help = text
	end

	def action(name, &block) 
		Runner.instance.add_action name, &block
	end

	def summary(text)
		Runner.instance.summary = text
	end

	def option(flag, text)
		Runner.instance.add_option flag, text
	end
end
