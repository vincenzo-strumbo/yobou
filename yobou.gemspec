Gem::Specification.new do |s|
  s.name        = "yobou"
  s.version     = "1.0.0"
  s.summary     = "A simple mysql/mysqldump wrapper"
  s.description = "A simple mysql/mysqldump wrapper"
  s.authors     = ["Vincenzo Strumbo"]
  s.files       = ["lib/yobou.rb"]
  s.homepage    =
    "https://rubygems.org/gems/yobou"
  s.license       = "MIT"

  s.add_development_dependency "rspec-core"
  s.add_development_dependency "rspec-expectations"
  s.add_development_dependency "rspec-mocks"
  s.add_development_dependency "mysql2"
end
