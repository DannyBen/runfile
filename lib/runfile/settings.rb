require 'ostruct'
require 'yaml'

module Runfile

  # The Settings class handles '.runfile' YAML config files.
  # If found in the current directory, we will use their content.
  class Settings
    def as_struct
      OpenStruct.new settings
    end

    private

    def settings
      @settings ||= settings!
    end

    def settings!
      File.file?('.runfile') ? YAML.load_file('.runfile') : {}
    end
  end

  module SettingsMixin
    def settings
      @settings ||= Settings.new.as_struct
    end

    def settings_present?
      File.file?('.runfile')
    end
  end

end
