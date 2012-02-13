require 'yaml'

version_yaml = YAML.load(File.open('VERSION.yml').read)
version = "#{version_yaml['major']}.#{version_yaml['minor']}.#{version_yaml['patch']}"
gem_name = "json-data_generator"

spec = Gem::Specification.new do |s|
  s.name = gem_name
  s.version = version
  s.authors = ["Pawel Lekki"]
  s.email = "pawel.lekki@gmail.com"
  s.homepage = "http://github.com/hoxworth/json-schema/tree/master"
  s.summary = "Ruby JSON Data Generator based on JSON Schema"
  s.files = Dir[ "lib/**/*"]
  s.require_path = "lib"
  s.test_files = Dir[ "test/**/test*", "test/{data,schemas}/*.json" ]
  s.extra_rdoc_files = ["README.textile"]
  s.add_runtime_dependency("json-schema",  ["~> 1.0.1"])
end
