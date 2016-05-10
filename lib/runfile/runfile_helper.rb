require 'docopt'
require 'pp'

module Runfile

  # The RunfileHelper class assists in:
  # 1. Finding named.runfiles
  # 2. Creating new runfiles (`run new`)
  # 3. Showing a list of found system runfiles in a colorful help
  class RunfileHelper
    include SettingsMixin
    
    # Handle the case when `run` is called without a Runfile 
    # present. We will let the user know they can type `run new`
    # to create a new sample Runfile.
    # If the first argument matches the name of a *.runfile name,
    # we will return it to the caller. Otherwise, we return false
    # to indicate "no further handling is needed".
    def handle(argv)
      # make a new runfile
      if argv[0] == "new" && !settings_present?
        make_runfile argv[1]
        return false
      end

      # get a list of *.runfile path-wide
      runfiles = find_runfiles || []

      # if first arg is a valid *.runfile, run it
      if argv[0] 
        runfile = runfiles.select { |f| f[/\/#{argv[0]}.runfile/] }.first
        runfile and return runfile
      end

      # if we are here, offer some help and advice and show a list
      # of possible runfiles to run.
      show_make_help runfiles, settings.folder
      return false
    end

    def purge_settings
      @settings = OpenStruct.new
    end

    private

    # Create a new runfile in the current directory. We can either
    # create a standard 'Runfile' or a 'named.runfile'.
    def make_runfile(name=nil)
      name = 'Runfile' if name.nil?
      template = File.expand_path("../templates/Runfile", __FILE__)
      name += ".runfile" unless name == 'Runfile'
      dest = "#{Dir.pwd}/#{name}"
      begin
        File.write(dest, File.read(template))
        puts "#{name} created."
      rescue => e
        abort "Failed creating #{name}\n#{e.message}"
      end
    end

    # Find all *.runfile files in our search difrectories
    def find_runfiles
      result = []
      dirs = runfile_folders
      dirs.each do |d|
        found = Dir[File.join(d, '*.runfile')]
        result << found unless found.empty?
      end
      return result.empty? ? false : result.flatten.uniq
    end

    # Show some helpful tips, and a list of available runfiles
    def show_make_help(runfiles, compact=false)
      say "!txtpur!Runfile engine v#{Runfile::VERSION}" unless compact
      if runfiles.size < 3 and !compact
        say "\nTip: Type '!txtblu!run new!txtrst!' or '!txtblu!run new name!txtrst!' to create a runfile.\nFor global access, place !txtblu!named.runfiles!txtrst! in ~/runfile/ or in /etc/runfile/."
      end
      if runfiles.empty? 
        say "\n!txtred!Runfile not found."
      else
        say ""
        compact ? say_runfile_usage(runfiles) : say_runfile_list(runfiles)
      end
    end

    # Return array of folders we should search in for runfiles.
    def runfile_folders
      # This trick allows searching in subfolders recursively, including
      # one level of symlinked folder
      subdirs = '**{,/*/**}'
      
      # If there is a '.runfile' settings file with a folder definition
      # in it, use it. Otherwise, search globally.
      if settings.folder
        ["#{settings.folder}/#{subdirs}"]
      else
        [Dir.pwd, "#{Dir.home}/runfile/#{subdirs}", "/etc/runfile/#{subdirs}"]
      end
    end
    
    # [UNUSED] Same as runfile_folders, but including PATH
    def runfile_folders_with_path
      dirs = path_dirs
      dirs.insert 0, Dir.pwd, "#{Dir.home}/runfile", "/etc/runfile"
      dirs
    end

    # Output the list of available runfiles
    def say_runfile_list(runfiles)
      runfile_paths = runfiles.map { |f| File.dirname f }
      max = runfile_paths.max_by(&:length).size
      width, height = detect_terminal_size
      runfiles.each do |f|
        f[/([^\/]+).runfile$/]
        command  = "run #{$1}"
        spacer_size = width - max - command.size - 6
        spacer_size = [1, spacer_size].max
        spacer = '.' * spacer_size
        say "  !txtgrn!#{command}!txtrst! #{spacer} #{File.dirname f}"
      end
    end

    # Output the list of available runfiles without filename
    def say_runfile_usage(runfiles)
      runfiles_as_columns = get_runfiles_as_columns runfiles
      
      say "#{settings.intro}\n" if settings.intro
      say "Usage: run <file>"
      say runfiles_as_columns

      show_shortcuts if settings.shortcuts
    end

    # Prints a friendly output of the shortcut list
    def show_shortcuts
      say "\nShortcuts:"
      max = settings.shortcuts.keys.max_by(&:length).length
      settings.shortcuts.each_pair do |shortcut, command|
        say "  #{shortcut.rjust max} : #{command}"
      end
    end

    # Returns the list of runfiles, organized as columns based on the
    # current terminal width
    def get_runfiles_as_columns(runfiles)
      namelist = runfile_names runfiles
      width = detect_terminal_size[0]
      max = namelist.max_by(&:length).length
      message = "  " + namelist.map {|f| f.ljust max+1 }.join(' ')
      word_wrap message, width
    end

    def runfile_names(runfiles)
      runfiles.map {|f| /([^\/]+).runfile$/.match(f)[1] }.sort
    end

    # Returns an array of path directories
    def path_dirs
      ENV['PATH'].split(File::PATH_SEPARATOR)
    end

  end
end
