require 'simplecov'

unless ENV['NOCOV']
  SimpleCov.start do
    enable_coverage :branch
    primary_coverage :branch
  end
end

require 'bundler'
Bundler.require :default, :development

require 'runfile'
FileUtils.mkdir_p 'spec/tmp'

# Consistent Colsole output (for rspec_approvals)
ENV['TTY'] = 'on'
ENV['FORCE_COLORS'] = '1'
ENV['COLUMNS'] = '80'
ENV['LINES'] = '30'

RSpec.configure do |config|
  include Runfile, Colsole
  config.example_status_persistence_file_path = 'spec/status.txt'
  # config.strip_ansi_escape = true
end
