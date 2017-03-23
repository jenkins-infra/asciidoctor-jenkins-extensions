# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asciidoctor/jenkins/extensions/version'

Gem::Specification.new do |spec|
  spec.name          = "asciidoctor-jenkins-extensions"
  spec.version       = Asciidoctor::Jenkins::Extensions::VERSION
  spec.authors       = ["R. Tyler Croy"]
  spec.email         = ["tyler@monkeypox.org"]

  spec.summary       =""
  spec.description   =""
  spec.homepage      = 'https://github.com/jenkins-infra'


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.add_dependency 'asciidoctor', '~> 1.5.5'
  spec.add_dependency 'coderay', '~> 1.1.1'
  spec.add_dependency 'colorize', '~> 0.8.1'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
end
