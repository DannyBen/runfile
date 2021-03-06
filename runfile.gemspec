lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'runfile/version'

Gem::Specification.new do |s|
  s.name        = 'runfile'
  s.version     = Runfile::VERSION
  s.date        = Date.today.to_s
  s.summary     = "If Rake and Docopt had a baby"
  s.description = "Build command line applications per project with ease. Rake-inspired, Docopt inside."
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.rb', 'lib/runfile/templates/*']
  s.executables = ["run", "run!"]
  s.homepage    = 'https://github.com/DannyBen/runfile'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.0.0"
  s.metadata    = {
    "homepage_uri"    => "https://github.com/DannyBen/runfile",
    "changelog_uri"   => "https://github.com/DannyBen/runfile/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/DannyBen/runfile",
    "bug_tracker_uri" => "https://github.com/DannyBen/runfile/issues"
  }

  s.add_runtime_dependency 'colsole', '~> 0.5'
  s.add_runtime_dependency 'docopt', '~> 0.5'
end
