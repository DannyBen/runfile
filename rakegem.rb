# Common rake tasks for gem building
# Require in your Rakefile and define $GEMNAME

desc "Build gem"
task :build do
	build_gem $GEMNAME
end

desc "Install local gem (version optional)"
task :install, :ver do |t, args|
	install_gem $GEMNAME, args[:ver]
end

desc "Build and install latest gem"
task :binstall do
	build_gem $GEMNAME
	install_gem $GEMNAME
end

desc "Publish gem (version optional)"
task :publish, :ver do |t, args|
	publish_gem $GEMNAME, args[:ver]
end

def build_gem(name)
	cmd = "gem build #{name}.gemspec"	
	puts "Running #{cmd}"
	system cmd
	files = Dir["*.gem"]
	puts "Moving to gems folder"
	files.each {|f| mv f, "gems" }
end

def install_gem(name, ver=nil)
	spec = Gem::Specification::load "#{name}.gemspec"
	version = ver || spec.version.to_s
	gemfile = "gems/#{name}-#{version}.gem"
	cmd = "gem install #{gemfile}"
	puts "Running: #{cmd}"
	system cmd
end

def publish_gem(name, ver=nil)
	spec = Gem::Specification::load "#{name}.gemspec"
	version = ver || spec.version.to_s
	gemfile = "gems/#{name}-#{version}.gem"
	File.exist? gemfile or abort "File not found #{gemfile}"
	cmd = "gem push #{gemfile}"
	puts "Running: #{cmd}"
	system cmd
end
