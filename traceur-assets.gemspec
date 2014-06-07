# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'traceur-assets/version'

Gem::Specification.new do |spec|
  spec.name          = 'traceur-assets'
  spec.version       = TraceurAssets::VERSION
  spec.authors       = ['Aaron Ackerman']
  spec.email         = ['theron17@gmail.com']
  spec.summary       = %q{Traceur Compiler integration with Sprockets}
  spec.description   = %q{Compile Traceur Compiler supported Javascript with Sprockets}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'execjs'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'tilt'
  spec.add_development_dependency 'sprockets', '> 2.0.0'
end
