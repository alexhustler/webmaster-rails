# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webmaster/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "webmaster-rails"
  spec.version       = Webmaster::Rails::VERSION
  spec.authors       = ["Slate"]
  spec.email         = ["alex@slatestudio.com"]
  spec.description   = %q{Tools for building websites}
  spec.summary       = %q{Tools for building websites}
  spec.homepage      = "http://www.slatestudio.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end