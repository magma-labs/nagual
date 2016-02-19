# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nagual'

Gem::Specification.new do |spec|
  spec.name          = 'nagual'
  spec.version       = Nagual::VERSION
  spec.authors       = ['Sawyer Effect']
  spec.email         = ['contact@sawyereffect.com']
  spec.summary       = 'Creates XML files for Demandware.'
  spec.description   = 'Parses input CSV files to import data to Demandware.'
  spec.homepage      = 'http://sawyereffect.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.executables   = ['nagual']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'nokogiri', '~> 1.6'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'rubocop', '~> 0.36'
end
