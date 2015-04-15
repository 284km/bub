# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bub/version"

Gem::Specification.new do |spec|
  spec.name          = "bub"
  spec.version       = Bub::VERSION
  spec.authors       = ["284km"]
  spec.email         = ["at284km@gmail.com"]

  spec.summary       = "Command-line tool for Bitbucket(git) to create and remove a repository."
  spec.description   = "Command-line tool for Bitbucket(git) to create and remove a repository."
  spec.homepage      = "https://github.com/284km/bub"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "pit"
  spec.add_runtime_dependency "http"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
