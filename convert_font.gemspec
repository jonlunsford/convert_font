# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'convert_font/version'

Gem::Specification.new do |spec|
  spec.name          = "convert_font"
  spec.version       = ConvertFont::VERSION
  spec.authors       = ["jonlunsford"]
  spec.email         = ["jon@capturethecastle.net"]
  spec.description   = %q{A CLI tool to convert fonts.}
  spec.summary       = %q{This tool takes a font file and converts it to the formats you need.}
  spec.homepage      = "https://github.com/jonlunsford/convert_font"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "unirest"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
