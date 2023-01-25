module Runfile
  # Finds the path of an installed or bundled gem
  # Adapted from Rubocop <https://github.com/rubocop/rubocop/blob/master/lib/rubocop/config_loader_resolver.rb#L268>
  class GemFinder
    class << self
      def find(gem_name, file = nil)
        gem_path = find_gem_path gem_name
        file ? File.join(gem_path, file) : gem_path
      rescue Gem::LoadError
        raise GemNotFound, "Cannot import gem nub`#{gem_name}`\nTry running g`gem install #{gem_name}`"
      end

    private

      def find_gem_path(gem_name)
        if bundler?
          gem = Bundler.load.specs[gem_name].first
          gem_path = gem.full_gem_path if gem
        end

        gem_path || Gem::Specification.find_by_name(gem_name).gem_dir
      end

      def bundler?
        defined? Bundler
      end
    end
  end
end
