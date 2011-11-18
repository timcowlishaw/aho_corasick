$: << File.dirname(__FILE__)
require 'spec_helper'

describe "AhoCorasick" do
  it "returns matched substrings" do
    a = AhoCorasick.new("ab")
    a.match("abcde").must_include("ab")
  end

  it "returns multiple matched substrings" do
    a  = AhoCorasick.new("ab", "cd")
    a.match("cd123ab").to_set.must_equal ["ab", "cd"].to_set
  end

  it "returns overlapping matched substrings" do
    a = AhoCorasick.new("ab", "bc")
    a.match("abc").to_set.must_equal ["ab", "bc"].to_set
  end

  it "does not return unmatched substrings" do
    a = AhoCorasick.new("ab")
    a.match("abc").wont_include("bc")
  end

  it "matches adjacent terms" do
    a = AhoCorasick.new("ab", "cd")
    a.match("abcd").to_set.must_equal ["ab", "cd"].to_set
  end

  it "matches terms directly following a partial match" do
    a = AhoCorasick.new("abc", "de")
    a.match("ade").must_include("de")
  end

  it "returns terms added to the matcher after instantiation" do
    a = AhoCorasick.new("ab")
    a.insert("cd", "ef")
    a.match("ab12cd12ef").to_set.must_equal ["ab", "cd", "ef"].to_set
  end

  describe "benchmarks" do

    before do
      words = 1000.times.map { rand(6).times.inject("") {|s,_| s + (65 + rand(26)).chr}}
      @matcher = AhoCorasick.new(*words)
    end

    bench_performance_linear "string matching" do |n|
      10.times do
        string = n.times.inject("") {|s, _| s + (65 + rand(26)).chr } 
        @matcher.match(string)
      end
    end
  end

end
