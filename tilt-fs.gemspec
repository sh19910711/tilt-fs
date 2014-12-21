# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tilt/fs/version'

Gem::Specification.new do |spec|
  spec.name = "tilt-fs"
  spec.version = Tilt::Fs::VERSION
  spec.authors = ["Hiroyuki Sano"]
  spec.email = ["sh19910711@gmail.com"]
  spec.summary = %q{Tilt based FUSE file system}
  spec.description = %q{Tilt based FUSE file system}
  spec.homepage = ""
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "tilt", "~> 2.0"
  spec.add_dependency "rfuse", "~> 1.1.0.RC0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit"
end
