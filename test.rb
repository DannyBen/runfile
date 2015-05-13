#!/usr/bin/env ruby

# Determines if a shell command exists by searching for it in ENV['PATH'].
def command_exists?(command)
	ENV['PATH'].split(File::PATH_SEPARATOR).any? {|d| File.exist? File.join(d, command) }
end

# Returns [width, height] of terminal when detected, nil if not detected.
# Think of this as a simpler version of Highline's Highline::SystemExtensions.terminal_size()
def detect_terminal_size
	if (ENV['COLUMNS'] =~ /^\d+$/) && (ENV['LINES'] =~ /^\d+$/)
		[ENV['COLUMNS'].to_i, ENV['LINES'].to_i]
	elsif (RUBY_PLATFORM =~ /java/ || (!STDIN.tty? && ENV['TERM'])) && command_exists?('tput')
		[`tput cols`.to_i, `tput lines`.to_i]
	elsif STDIN.tty? && command_exists?('stty')
		`stty size`.scan(/\d+/).map { |s| s.to_i }.reverse
	else
		nil
	end
end

width, height = detect_terminal_size

# def wrap(s, width)
# 	s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
# end

class String
	def wrap(length=80, character=$/)
		lead = self[/^\s+/]
		length -= lead.size
		scan(/.{#{length}}|.+/).map { |x| "#{lead}#{x.strip}" }.join(character)
	end
end

str = "  1 3 5 7 9 this is a long line that should be indented properly"
out = str.wrap 10
p out

