require 'minitest/autorun'
require 'yaml'
require 'colsole'
require 'runfile/version'
require 'fileutils'

# minitest reference
# http://www.mattsears.com/articles/2011/12/10/minitest-quick-reference

class RunfileMakerTest < Minitest::Test
	include Colsole

	@@dir = "runfile_testbox"

	def test_maker
		conf = YAML.load_file 'test/maker_cases.yml'
		say "\n\n!txtpur!Starting maker tests"
		Dir.mkdir @@dir
		Dir.chdir @@dir do 
			conf.each do |test|
				say "!txtgrn!#{test['cmd']}"
				output = `#{test['cmd']}`.strip 
				expected = test['out'] % { version: Runfile::VERSION }
				if test['chk'] == 'regex'
					assert_match /#{expected}/, output
				else
					assert_equal expected, output
				end
				test['has'] and assert File.file?(test['has'])
				test['del'] and File.delete test['has']
			end
		end
	end

	Minitest.after_run do
		puts "After Run Hook: Removing #{@@dir}"
		FileUtils.rm_r @@dir
	end
end