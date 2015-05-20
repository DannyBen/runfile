require 'minitest/autorun'
require 'yaml'
require 'colsole'
require 'runfile/version'

# minitest reference
# http://www.mattsears.com/articles/2011/12/10/minitest-quick-reference

class RunfileExampleTest < Minitest::Test
	include Colsole
	def test_examples
		conf = YAML.load_file 'test/example_cases.yml'
		conf.each do |test|
			Dir.chdir "examples/#{test['dir']}" do
				say "!txtpur!#{test['dir'].rjust 20} : !txtgrn!#{test['cmd']}"
				output = `#{test['cmd']}`.strip 
				expected = test['out'] % { version: Runfile::VERSION }
				if test['chk'] == 'regex'
					assert_match /#{expected}/, output
				else
					assert_equal expected, output
				end
			end
		end
	end
end