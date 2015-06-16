# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_agenda/version'

Gem::Specification.new do |spec|
  spec.name          = "open-agenda-ruby"
  spec.version       = OpenAgenda::VERSION
  spec.authors       = ["Nicolas Florentin"]
  spec.email         = ["nicolas@sleede.com"]
  spec.summary       = 'A lightweight ruby wrapper to consume OpenAgenda API'
  spec.description   = 'open-agenda-ruby is a lightweight but complete ruby wrapper to consume OpenAgenda API'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'

  spec.add_runtime_dependency('multi_json')
  spec.add_runtime_dependency('hashie', '3.4.1')
  spec.add_runtime_dependency('faraday_middleware')
end
