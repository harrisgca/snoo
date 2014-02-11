# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snoo/version'

Gem::Specification.new do |spec|
  spec.name          = "snoo"
  spec.version       = Snoo::VERSION
  spec.authors       = ["Jeff Sandberg"]
  spec.email         = ["paradox460@gmail.com"]
  spec.summary       = "the reddit gem"
  spec.description   = "snoo is a simple gem providing a ruby wrapper around the reddit API"
  spec.homepage      = "https://github.com/paradox460/snoo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "faker"
end
