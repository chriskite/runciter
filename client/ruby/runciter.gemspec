spec = Gem::Specification.new do |s|
  s.name = "runciter"
  s.version = "0.0.2"
  s.author = "Chris Kite"
  s.homepage = "http://www.github.com/chriskite/runciter"
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby client for the Runciter task monitor"
  s.require_path = "lib"
  s.has_rdoc = false 
  #s.rdoc_options << '-m' << 'README.rdoc' << '-t' << 'Jimson'
  s.extra_rdoc_files = ["README.md"]
  s.add_dependency("jimson", ">= 0.9.1")

  s.files = %w[
    VERSION
    LICENSE.txt
    CHANGELOG.md
    README.md
    Rakefile
  ] + Dir['lib/**/*.rb']

  s.test_files = Dir['spec/*.rb']
end
