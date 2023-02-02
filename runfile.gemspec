lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'runfile/version'

Gem::Specification.new do |s|
  s.name        = 'runfile'
  s.version     = Runfile::VERSION
  s.summary     = 'Local command line for your projects'
  s.description = 'Build expressive command line utilities for your projects.'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir[
    'README.md',
    'lib/**/*.rb',
    'lib/runfile/templates/*',
    'lib/runfile/views/*.gtx',
    'examples/**/{runfile,*.runfile,*.rb}',
  ]
  s.executables = ['run']
  s.homepage    = 'https://github.com/DannyBen/runfile'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.7'

  s.metadata = {
    'homepage_uri'          => 'https://github.com/DannyBen/runfile',
    'changelog_uri'         => 'https://github.com/DannyBen/runfile/blob/master/CHANGELOG.md',
    'source_code_uri'       => 'https://github.com/DannyBen/runfile',
    'bug_tracker_uri'       => 'https://github.com/DannyBen/runfile/issues',
    'rubygems_mfa_required' => 'true',
  }

  s.add_runtime_dependency 'colsole', '>= 0.8.2', '< 2.0'
  s.add_runtime_dependency 'docopt_ng', '~> 0.7'
  s.add_runtime_dependency 'gtx', '~> 0.1'
  s.add_runtime_dependency 'requires', '>= 0.2', '< 2.0'
end
