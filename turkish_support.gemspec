# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'turkish_support/version'

Gem::Specification.new do |spec|
  spec.name          = "turkish_support"
  spec.version       = TurkishSupport::VERSION
  spec.authors       = ["Sıtkı Bağdat"]
  spec.email         = ["sbagdat@gmail.com"]
  spec.summary       = %q{Turkish characters support for upcase, downcase, etc.}
  spec.description   = %q{A gem for Turkish character support for String#upcase, String#downcase, String#capitalize methods and their destructive versions like String#upcase!. In other words; this gem is a lighter version of the UnicodeUtils gem. }
  spec.homepage      = "https://github.com/sbagdat/turkish_support"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0.0"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
