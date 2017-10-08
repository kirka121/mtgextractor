# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Joel Andritsch", "Damon Butler"]
  gem.email         = ["joel.andritsch@gmail.com", "iamdamocles@gmail.com"]
  gem.description   = %q{MTGExtractor is a Ruby gem that allows you to extract Magic: The Gathering card information from the Gatherer website.}
  gem.summary       = %q{Extract MTG card data from Gatherer}
  gem.homepage      = "https://github.com/JAndritsch/mtgextractor"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mtgextractor"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.3"

  gem.add_dependency "rest-client"
  gem.add_dependency "rspec"

end
