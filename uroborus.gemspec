# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uroborus/version'

Gem::Specification.new do |gem|
  gem.name          = "uroborus"
  gem.version       = Uroborus::VERSION
  gem.authors       = ["Lex Childs"]
  gem.email         = ["lexchilds@gmail.com"]
  gem.description   = %q{P2P file Backup system}
  gem.summary       = %q{P2P file Backup system}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end