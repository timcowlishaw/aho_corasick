$: << File.join(File.dirname(__FILE__),"..")
require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'lib/aho_corasick'
RSpec.configure do |config|
  #config.mock_framework = :mocha
end

