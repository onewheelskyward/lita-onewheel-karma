Gem::Specification.new do |spec|
  spec.name          = 'lita-onewheel-karma'
  spec.version       = '0.0.0'
  spec.authors       = ['Andrew Kreps']
  spec.email         = ['andrew.kreps@gmail.com']
  spec.description   = 'Karma with a maths-focused twist.'
  spec.summary       = "Karma shouldn't be bound by simple increment and decrement operations."
  spec.homepage      = 'https://github.com/onewheelskyward/lita-onewheel-karma'
  spec.license       = 'MIT'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '>= 4.4'

  spec.add_development_dependency 'bundler', '~> 1.3'
  # spec.add_development_dependency 'pry-byebug'  # I go inline.
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
end
