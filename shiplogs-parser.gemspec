# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shiplogs/parser/version'

Gem::Specification.new do |spec|
  spec.name          = "shiplogs-parser"
  spec.version       = Shiplogs::Parser::VERSION
  spec.authors       = ["Will Fisher"]
  spec.email         = ["will@alaska.edu"]
  spec.summary       = %q{Basic html parser for shiplogs}
  spec.description   = %q{Basic html parser for shiplogs}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_dependency 'nokogiri', '~> 1.6.3'
end
