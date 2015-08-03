# Utility methods
module Runfile
  # Debug print and exit
  # Smells of :reek:UncommunicativeMethodName
  def d(obj)
    pp obj 
    exit
  end

  # Return an array of path directories
  # Smells of :reek:UtilityFunction
  def path_dirs
    ENV['PATH'].split(File::PATH_SEPARATOR)
  end
end