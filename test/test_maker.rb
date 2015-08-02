require 'minitest/autorun'
require 'yaml'
require 'colsole'
require 'runfile/version'
require 'fileutils'

# minitest reference
# http://www.mattsears.com/articles/2011/12/10/minitest-quick-reference

class RunfileMakerTest < Minitest::Test
	include Colsole

	DIR = "runfile_testbox"

	def test_maker
		@conf = YAML.load_file 'test/maker_cases.yml'
		say "\n\n!txtpur!Starting maker tests"
		Dir.mkdir DIR
		Dir.chdir DIR do 
			run_dir_test
		end
	end

	def run_dir_test
		@conf.each do |test|
			run_test test
		end
	end

	# Smells of :reek:TooManyStatements, :reek:FeatureEnvy
	def run_test(test)
		actual = execute test['cmd']
		expected = test['out'] % { version: Runfile::VERSION }
		if test['chk'] == 'regex'
			assert_match /#{expected}/, actual
		else
			assert_equal expected, actual
		end
		has = test['has']
		has and assert File.file?(has)
		test['del'] and File.delete has
	end

	def execute(cmd)
		say "!txtgrn!#{cmd}"
		`#{cmd}`.strip 
	end

	Minitest.after_run do
		puts "After Run Hook: Removing #{DIR}"
		FileUtils.rm_r DIR
	end
end