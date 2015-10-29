lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'runfile/version'

Gem::Specification.new do |s|
  s.name        = 'runfile'
  s.version     = Runfile::VERSION
  s.date        = Date.today.to_s
  s.summary     = "If Rake and Docopt had a baby"
  s.description = "A beautiful command line application framework. Rake-inspired, Docopt inside."
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.rb', 'lib/runfile/templates/*']
  s.executables = ["run", "run!"]
  s.homepage    = 'https://github.com/DannyBen/runfile'
  s.license     = 'MIT'

  s.add_runtime_dependency 'colsole', '~> 0.2'
  s.add_runtime_dependency 'docopt', '~> 0.5'

  s.add_development_dependency 'minitest', '~> 5.8'
  s.add_development_dependency 'run-gem-dev', '~> 0.2'
end
