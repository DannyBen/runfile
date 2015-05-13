Gem::Specification.new do |s|
  s.name        = 'Run'
  s.version     = '0.1.0'
  s.date        = '2015-05-13'
  s.summary     = "If Rake and Docopt had a baby"
  s.description = "An easy way to create project specific command line utilities"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = [
    "lib/run.rb", 
    "lib/run/action.rb", 
    "lib/run/docopt_maker.rb",
    "lib/run/runner.rb",
    "lib/run/dsl.rb",
  ]
  s.executables = ["run"]
  s.homepage    = 'http://sector-seven.net'
  s.license     = 'MIT'

  s.add_runtime_dependency 'colones', '~> 0'
  s.add_runtime_dependency 'docopt', '~> 0.5'
end
