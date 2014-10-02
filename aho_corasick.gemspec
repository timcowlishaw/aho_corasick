# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'aho_corasick/version'

Gem::Specification.new do |s|
  s.name = "aho_corasick"
  s.version = AhoCorasick::VERSION

  s.authors = ["Tim Cowlishaw"]
  s.date = "2014-10-02"
  s.email = "tim@timcowlishaw.co.uk"
  s.files = Dir.glob("lib/**/*")  + ["README.md"]
  s.homepage = "http://github.com/timcowlishaw/aho_corasick"
  s.licenses = ["MIT"]
  s.require_path = "lib"
  s.summary = "The Aho-Corasick string-matching algorithm"
  s.description = "An algorithm that allows searching for members of a known set of strings appearing as substrings of a larger string in time linear to both the size of the string and the size of the set"


  s.add_development_dependency("rspec", "~> 3.1")
end
