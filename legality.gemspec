# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'legality/version'

Gem::Specification.new do |spec|
  spec.name          = "legality"
  spec.version       = Legality::VERSION
  spec.authors       = ["Daniel Berkompas"]
  spec.email         = ["daniel@leadsimple.com"]
  spec.description   = %q{Determines the legality of given actions.}
  spec.summary       = %q{Determines the legality of given actions.}
  spec.homepage      = "http://leadsimple.com"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 4.1'
end
