require 'minitest/autorun'
require 'yaml'
require 'colsole'

# minitest reference
# http://www.mattsears.com/articles/2011/12/10/minitest-quick-reference

class ColsoleTest < Minitest::Test
	include Colsole
	def test_examples
		conf = YAML.load_file 'test/cases.yml'
		conf.each do |test|
			Dir.chdir "examples/#{test['dir']}" do
				say "!txtpur!#{test['dir'].rjust 15} : #{test['cmd']}"
				output = `#{test['cmd']}`.strip
				assert_equal test['out'], output
			end
		end
	end
end