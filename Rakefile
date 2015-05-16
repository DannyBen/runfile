require 'rake/testtask'
require 'rdoc/task'
require 'yaml'

task :default do 
	system "rake -T"
end

# test task
Rake::TestTask.new {|t| t.libs << 'test'}

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

desc "Build gem"
task :build do
	system "gem build runfile.gemspec"	
	files = Dir["*.gem"]
	files.each {|f| mv f, "gems" }
end

desc "Publish gem"
task :publish, :ver do |t, args|
	args[:ver] or abort "Please specify a version\nExample rake publish[0.1.2]"
	gemfile = "gems/runfile-#{args[:ver]}.gem"
	File.exist? gemfile or abort "File not found #{gemfile}"
	cmd = "gem push #{gemfile}"
	puts "Running: #{cmd}"
	system cmd
end

desc "Add example case to test/case.yml"
task :addtest, :dir, :cmd do |t, args|
	casefile = 'test/cases.yml'
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
