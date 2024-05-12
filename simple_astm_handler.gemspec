# astm_handler.gemspec
Gem::Specification.new do |s|
  s.name        = 'simple_astm_handler'
  s.version     = '0.1.0'
  s.date        = '2024-05-12'
  s.summary     = "ASTM Message Handler Gem"
  s.description = "A Ruby gem for parsing and generating ASTM messages used in medical laboratories."
  s.authors     = ["Vamsi Krishna"]
  s.email       = 'rvk0106@gmail.com'
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir      = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.license     = 'MIT'

  s.add_dependency 'json', '~> 2.5'

  s.add_development_dependency 'bundler', '~> 2.1'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.10'
end
