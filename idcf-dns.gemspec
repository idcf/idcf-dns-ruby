# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "idcf/dns/version"

Gem::Specification.new do |spec|
  spec.name          = "idcf-dns"
  spec.version       = Idcf::Dns::VERSION
  spec.authors       = ["IDC Frontier Inc."]

  spec.summary       = "A Ruby client for IDCF Cloud DNS Service."
  spec.homepage      = "https://github.com/idcf/idcf-dns-ruby"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "awesome_print"

  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"

  spec.required_ruby_version = ">= 2.1.10"
end
