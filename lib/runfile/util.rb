module Runfile

	# Debug print and exit
	def d(obj)
		p obj 
		exit
	end

	# Find a single file in any of the path directories
	def find_in_path(file)
		ENV['PATH'].split(File::PATH_SEPARATOR).any? do |d|
			candidate = File.join(d, file)
			return candidate if File.exist? candidate
		end
		false
	end

	# Find all files matching a pattern in any of the path directories
	def find_all_in_path(pattern, include_cwd=true)
		result = []
		dirs = ENV['PATH'].split(File::PATH_SEPARATOR)
		dirs.insert(0, Dir.pwd) if include_cwd 
		dirs.each do |d|
			found = Dir[File.join(d, pattern)]
			result << found unless found.empty?
		end
		return result.empty? ? false : result.flatten
	end
end