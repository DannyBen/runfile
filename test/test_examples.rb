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
    say "\n\n!txtpur!Starting example tests"
    conf.each do |test|
      run_dir_test test
    end
  end

  # Smells of :reek:TooManyStatements, :reek:FeatureEnvy
  def run_dir_test(test) 
    dir = test['dir']
    Dir.chdir "examples/#{dir}" do
      actual = execute(dir, test['cmd'])
      expected = test['out'] % { version: Runfile::VERSION }
      if test['chk'] == 'regex'
        assert_match /#{expected}/, actual
      else
        assert_equal expected, actual
      end
    end
  end

  def execute(dir, cmd) 
    say "!txtpur!#{dir.rjust 20} : !txtgrn!#{cmd}"
    `#{cmd}`.strip 
  end
end