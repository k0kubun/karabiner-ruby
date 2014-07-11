# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dotremap/version'

Gem::Specification.new do |spec|
  spec.name          = "dotremap"
  spec.version       = Dotremap::VERSION
  spec.authors       = ["Takashi Kokubun"]
  spec.email         = ["takashikkbn@gmail.com"]
  spec.summary       = %q{Configuration DSL for KeyRemap4MacBook}
  spec.description   = %q{Configuration DSL for KeyRemap4MacBook}
  spec.homepage      = "https://github.com/k0kubun/dotremap"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_dependency 'unindent', '~> 1.0'
end
