# frozen_string_literal: true

require("yaml")

module Bootstrap
  class Package
    SOURCE_FILE = File.expand_path("package/sources.yml", __dir__)

    private_constant(:SOURCE_FILE)

    attr_reader :name, :environment

    def self.sources
      @sources ||= YAML.safe_load(File.read(SOURCE_FILE))
    end

    def initialize(name, environment:)
      @name = name
      @environment = environment
    end

    def install
      first_party_install if source.first_party?
      third_party_install if source.third_party?
      script_install if source.script?
    end

    private

    def source
      @source ||= Source.new(
        self,
        **self.class.sources.dig(name, @environment.platform.to_s).to_h.transform_keys(&:to_sym)
      )
    end

    def first_party_install
      source.package_manager.install(source.name)
    end

    def third_party_install
      source.package_manager.source(source.location)
      source.package_manager.install(source.name)
    end

    def script_install
      @environment.run(source.script)
    end
  end
end
