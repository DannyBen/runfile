require 'rake/testtask'
require 'rdoc/task'

task :default do 
	system "rake -T"
end

# test task
Rake::TestTask.new {|t| t.libs << 'test'}

# rdoc tasks
Rake::RDocTask.new do |rdoc|
	files = ['README.md', 'lib/colsole.rb']
	rdoc.rdoc_files.add(files)
	rdoc.main = "README.md"
	rdoc.title = "Colsole Docs"
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