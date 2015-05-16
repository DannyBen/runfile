Gem::Specification.new do |s|
  s.name        = 'runfile'
  s.version     = '0.2.1'
  s.date        = '2015-05-16'
  s.summary     = "If Rake and Docopt had a baby"
  s.description = "An easy way to create project specific command line utilities"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = [
    "lib/runfile.rb", 
    "lib/runfile/action.rb", 
    "lib/runfile/docopt_maker.rb",
    "lib/runfile/runner.rb",
    "lib/runfile/dsl.rb",
  ]
  s.executables = ["run"]
  s.homepage    = 'https://github.com/DannyBen/runfile'
  s.license     = 'MIT'

  s.add_runtime_dependency 'colsole', '~> 0'
  s.add_runtime_dependency 'docopt', '~> 0.5'
end
