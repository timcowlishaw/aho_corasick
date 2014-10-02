# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "aho_corasick"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Cowlishaw"]
  s.date = "2011-11-18"
  s.email = "tim@timcowlishaw.co.uk"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["Gemfile", "Gemfile.lock", "Rakefile", "README.md", "spec/aho_corasick_spec.rb", "spec/spec_helper.rb", "lib/aho_corasick.rb"]
  s.homepage = "http://github.com/timcowlishaw/aho_corasick"
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "The Aho-Corasick string-matching algorithm"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
