# frozen_string_literal: true

require_relative "lib/brazilian_docs/version"

Gem::Specification.new do |spec|
  spec.name = "brazilian_docs"
  spec.version = BrazilianDocs::VERSION
  spec.authors = ["tiberio_s_ferreira"]
  spec.email = ["tiberio.ferreiracs@gmail.com"]

  spec.summary = "Validação e formatação de CPF e CNPJ brasileiros."
  spec.description = "Uma gem Ruby para validar e formatar documentos brasileiros como CPF e CNPJ."
  spec.homepage = "https://github.com/tibas-ce/brazilian_docs"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.12"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
