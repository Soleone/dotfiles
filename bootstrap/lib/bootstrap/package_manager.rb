# frozen_string_literal: true

module Bootstrap
  class PackageManager
    class << self
      def command_name
        @command_name ||= name.dup.tap do |class_name|
          class_name.delete_prefix!("Bootstrap::")
          class_name.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
          class_name.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
          class_name.tr!("-", "_")
          class_name.gsub!("::", "-")
          class_name.downcase!
        end
      end

      def install(package_name)
        system(command_name, "install", package_name)
      end

      def source(_location)
        raise(NotImplementedError)
      end
    end
  end

  class Brew < PackageManager
    CASKS_FILE = File.expand_path("package/casks.yml", __dir__)
    CASKS_URL = "https://formulae.brew.sh/api/cask.json"

    private_constant(:CASKS_FILE, :CASKS_URL)

    class << self
      def install(package_name)
        if cask?(package_name)
          system(command_name, "cask", "install", package_name)
        else
          super
        end
      end

      def source(location)
        system(command_name, "tap", location)
      end

      private

      def cask_packages
        @cask_packages ||= begin
          require("yaml")
          if File.exist?(CASKS_FILE)
            YAML.safe_load(File.read(CASKS_FILE))
          else
            download_casks.tap { |data| File.write(CASKS_FILE, YAML.dump(data)) }
          end
        end
      end

      def download_casks
        require("net/http")
        require("json")
        response = Net::HTTP.get(URI(CASKS_URL))
        JSON.parse(response).map { |package| package["token"] }
      end

      def cask?(package_name)
        cask_packages.include?(package_name)
      end
    end
  end

  class Winget < PackageManager
    class << self
      def install(package_name)
        system(command_name, "install", "-e", package_name.capitalize)
      end
    end
  end

  class Apt < PackageManager
    class << self
      def install(package_name)
        system(command_name, "install", "-y", package_name)
      end

      def source(location)
        system("add-apt-repository", location)
        system(command_name, "update")
      end
    end
  end

  class Snap < PackageManager
    class << self
      def install(package_name)
        system(command_name, "install", "--classic", package_name)
      end
    end
  end

  private_constant(:PackageManager, :Brew, :Winget, :Apt, :Snap)
end
