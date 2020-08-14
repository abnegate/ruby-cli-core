# frozen_string_literal: true

require_relative "lib/cli-core/version"

Gem::Specification.new do |spec|
  spec.name = "cli-core"
  spec.version = CliCore::VERSION
  spec.authors = ["Jake Barnby"]
  spec.email = ["jakeb994@gmail.com"]

  spec.summary = "CLI Development core files"
  spec.description = "CLI Development core files"
  spec.homepage = "https://github.com/abnegate/ruby-cli-core"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/abnegate/ruby-cli-core"
  spec.metadata["changelog_uri"] = "https://github.com/abnegate/ruby-cli-core/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "pastel", "~> 0.7.3"
  spec.add_dependency "thor", "~> 0.20.3"
  spec.add_dependency "tty-spinner", "~> 0.9.3"

  spec.add_development_dependency "aruba"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "standard"
end
