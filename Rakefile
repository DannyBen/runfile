require 'rake/testtask'
require 'rdoc/task'
require 'yaml'
require_relative "rakegem"

$GEMNAME = "runfile"

task :default do 
	system "rake -T"
end

# test task
Rake::TestTask.new {|t| t.libs << 'test'}

desc "Test a single test file"
task :testone, :name do |t, args|
	cmd = "rake test TEST=test/test_#{args[:name]}.rb"
	puts cmd
	system cmd
end

# rdoc tasks
Rake::RDocTask.new do |rdoc|
	files = [
		'README.md', 'lib/runfile/action.rb', 
		'lib/runfile/docopt_maker.rb', 'lib/runfile/dsl.rb', 
		'lib/runfile/runner.rb'
	]

	rdoc.rdoc_files.add(files)
	rdoc.main = "README.md"
	rdoc.title = "Runfile Docs"
	rdoc.rdoc_dir = 'doc/rdoc'

	rdoc.options << '--line-numbers'
	rdoc.options << '--all'
	# rdoc.options << '--ri'
end

desc "Add example case to test/example_cases.yml"
task :addtest, :dir, :cmd do |t, args|
	casefile = 'test/example_cases.yml'
	args[:dir] and args[:cmd] or abort "Please provide dir and cmd\nExample: rake addtest[b_basic,\"run greet danny\"]"
	cases = YAML.load_file casefile
	cases or cases = []
	new_case = {'dir' => args[:dir], 'cmd' => args[:cmd]}
	Dir.chdir "examples/#{args[:dir]}" do
		new_case['out'] = `#{args[:cmd]}`.strip
	end
	cases << new_case
	File.write(casefile, YAML.dump(cases))
end

desc "Add example case to test/maker_cases.yml"
task :addtest2, :cmd do |t, args|
	casefile = 'test/maker_cases.yml'
	args[:cmd] or abort "Please provide cmd\nExample: rake addtest2[\"run greet danny\"]"
	cases = YAML.load_file casefile
	cases or cases = []
	new_case = {'cmd' => args[:cmd], }
	Dir.chdir "dev" do
		new_case['out'] = `#{args[:cmd]}`.strip
	end
	cases << new_case
	File.write(casefile, YAML.dump(cases))
end
