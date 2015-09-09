# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_q_l/version'

Gem::Specification.new do |spec|
  spec.name          = "json_q_l"
  spec.version       = JsonQL::VERSION
  spec.authors       = ["Matt Eddy"]
  spec.email         = ["matteddy1@gmail.com"]

  spec.summary       = "A SQL like JSON query language"
  spec.description   = "A SQL like JSON query language"
  spec.homepage      = "http://gfycat.com/BeautifulWholeAtlanticblackgoby"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ["jql"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
