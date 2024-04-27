# -*- encoding: utf-8 -*-
# stub: aws-sdk-core 3.193.0 ruby lib

Gem::Specification.new do |s|
  s.name = "aws-sdk-core".freeze
  s.version = "3.193.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/aws/aws-sdk-ruby/tree/version-3/gems/aws-sdk-core/CHANGELOG.md", "source_code_uri" => "https://github.com/aws/aws-sdk-ruby/tree/version-3/gems/aws-sdk-core" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Amazon Web Services".freeze]
  s.date = "2024-04-25"
  s.description = "Provides API clients for AWS. This gem is part of the official AWS SDK for Ruby.".freeze
  s.homepage = "https://github.com/aws/aws-sdk-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.5.6".freeze
  s.summary = "AWS SDK for Ruby - Core".freeze

  s.installed_by_version = "3.5.6".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<jmespath>.freeze, ["~> 1".freeze, ">= 1.6.1".freeze])
  s.add_runtime_dependency(%q<aws-partitions>.freeze, ["~> 1".freeze, ">= 1.651.0".freeze])
  s.add_runtime_dependency(%q<aws-sigv4>.freeze, ["~> 1.8".freeze])
  s.add_runtime_dependency(%q<aws-eventstream>.freeze, ["~> 1".freeze, ">= 1.3.0".freeze])
end
