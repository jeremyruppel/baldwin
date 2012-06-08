# -*- encoding: utf-8 -*-
require File.expand_path('../lib/baldwin/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Ruppel"]
  gem.email         = ["jeremy.ruppel@gmail.com"]
  gem.description   = %q{Bootstrap testing your rails 3 engine}
  gem.summary       = %q{Bootstrap testing your rails 3 engine}
  gem.homepage      = "https://github.com/jeremyruppel/baldwin"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "baldwin"
  gem.require_paths = ["lib"]
  gem.version       = Baldwin::VERSION

  gem.add_dependency 'rails',       '>= 3.0.0'
  gem.add_dependency 'rspec-rails', '>= 2.10.0'
  gem.add_dependency 'appraisal',   '>= 0.4.1'
  gem.add_dependency 'thor',        '>= 0.14.6'

  gem.add_development_dependency 'rspec', '2.10.0'
end
