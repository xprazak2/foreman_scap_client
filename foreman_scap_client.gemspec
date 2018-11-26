# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foreman_scap_client/version'

Gem::Specification.new do |spec|
  spec.name          = "foreman_scap_client"
  spec.version       = ForemanScapClient::VERSION
  spec.authors       = ["Marek Hulan", "Šimon Lukašík", "Shlomi Zadok"]
  spec.email         = ["mhulan@redhat.com", "slukasik@redhat.com", "szadok@redhat.com"]
  spec.summary       = %q{Client script that runs openscap scan and uploads the result to foreman proxy}
  spec.description   = %q{Client script that runs openscap scan and uploads the result to foreman proxy}
  spec.homepage      = "https://github.com/openscap/foreman_scap_client"
  spec.license       = "GPL-3.0"

  spec.files         = Dir["{bin,config,lib}/**/*", "LICENSE", "README.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.test_files    = Dir["test/**/*"]
  spec.require_paths = ["lib"]

  spec.requirements = '/usr/bin/bzip2'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "posix-spawn", "~> 0.3.13"
  spec.add_dependency "json", "~> 1.4.6" if RUBY_VERSION.start_with? '1.8'
end
