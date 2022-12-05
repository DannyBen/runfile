lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'sample_import_gem'
  s.version     = '0.0.0'
  s.summary     = 'Runfiles that can be imported with import_gem'
  s.description = 'Runfiles that can be imported with import_gem'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['*.runfile']
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.7'
  s.metadata['rubygems_mfa_required'] = 'true'
end
