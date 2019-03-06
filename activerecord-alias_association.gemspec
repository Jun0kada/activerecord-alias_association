
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord/alias_association/version'

Gem::Specification.new do |spec|
  spec.name          = 'activerecord-alias_association'
  spec.version       = Activerecord::AliasAssociation::VERSION
  spec.authors       = ['Jun0kada']
  spec.email         = ['jun.0kada.dev@gmail.com']

  spec.summary       = 'Add activerecord association alias'
  spec.description   = 'Add activerecord association alias'
  spec.homepage      = 'https://github.com/Jun0kada/activerecord-alias_association'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 5.0.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3', '~> 1.3.6'
end
