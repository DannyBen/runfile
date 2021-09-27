module Runfile
  module Refinements
    refine String do
      def word_wrap(length = nil)
        text = self

        length ||= Terminal.width
        lead = text[/^\s*/]
        text.strip!
        length -= lead.length
        text.split("\n").collect! do |line|
          if line.length > length
            line.gsub!(/([^\s]{#{length}})([^\s$])/, "\\1 \\2")
            line.gsub(/(.{1,#{length}})(\s+|$)/, "#{lead}\\1\n").rstrip
          else
            "#{lead}#{line}"
          end
        end * "\n"
      end
    end
  end
end