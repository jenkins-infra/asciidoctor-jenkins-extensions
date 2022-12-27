# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asciidoctor/jenkins/extensions/version'

Gem::Specification.new do |spec|
  spec.name          = "asciidoctor-jenkins-extensions"
  spec.version       = Asciidoctor::Jenkins::Extensions::VERSION
  spec.authors       = ["R. Tyler Croy"]
  spec.email         = ["tyler@monkeypox.org"]

  spec.summary       = "a collection of Asciidoctor extensions which enable more advanced
formatting in Jenkins-related content.
"
  spec.description   = "a collection of Asciidoctor extensions which enable more advanced
formatting in Jenkins-related content.
"
  spec.homepage      = 'https://github.com/jenkins-infra/asciidoctor-jenkins-extensions'


  root = File.dirname(__FILE__)
  spec.files         = Dir.glob("#{root}/lib/**/*.rb").map { |f| f.gsub("#{root}/", '') }
  spec.files         << File.basename(__FILE__)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.add_dependency 'asciidoctor', '>= 2.0.18'
  spec.add_dependency 'coderay', '~> 1.1.3'
  spec.add_dependency 'colorize', '~> 0.8.1'

  spec.add_development_dependency "bundler", "~> 2.3.26"
  spec.add_development_dependency "rake", "~> 13.0.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency 'pry'
end
