# This file provides some terminal related utilities (extracted from Colsole)

module Runfile
  class Terminal
    class << self
      def size(default = [80,30])
        if (ENV['COLUMNS'] =~ /^\d+$/) && (ENV['LINES'] =~ /^\d+$/)
          result = [ENV['COLUMNS'].to_i, ENV['LINES'].to_i]
        elsif (RUBY_PLATFORM =~ /java/ || (!STDIN.tty? && ENV['TERM'])) && command_exist?('tput')
          result = [`tput cols 2>&1`.to_i, `tput lines 2>&1`.to_i]
        elsif STDIN.tty? && command_exist?('stty')
          result = `stty size 2>&1`.scan(/\d+/).map { |s| s.to_i }.reverse
        else
          result = default
        end
        result = default unless result[0].is_a? Integer and result[1].is_a? Integer and result[0] > 0 and result[1] > 0
        result
      end

      def width
        size[0]
      end

      def command_exist?(command)
        ENV['PATH'].split(File::PATH_SEPARATOR).any? do |dir|
          File.exist?(File.join dir, command) or File.exist?(File.join dir, "#{command}.exe")
        end
      end

    end
  end
end