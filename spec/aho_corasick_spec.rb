$: << File.dirname(__FILE__)
require 'spec_helper'

describe "AhoCorasick" do
  it "returns matched substrings" do
    a = AhoCorasick.new("ab")
    expect(a.match("abcde")).to include("ab")
  end

  it "returns multiple matched substrings" do
    a  = AhoCorasick.new("ab", "cd")
    expect(a.match("cd123ab").to_set).to eq ["ab", "cd"].to_set
  end

  it "returns overlapping matched substrings" do
    a = AhoCorasick.new("ab", "bc")
    expect(a.match("abc").to_set).to eq ["ab", "bc"].to_set
  end

  it "does not return unmatched substrings" do
    a = AhoCorasick.new("ab")
    expect(a.match("abc")).not_to include("bc")
  end

  it "matches adjacent terms" do
    a = AhoCorasick.new("ab", "cd")
    expect(a.match("abcd").to_set).to eq ["ab", "cd"].to_set
  end

  it "matches terms directly following a partial match" do
    a = AhoCorasick.new("abc", "de")
    expect(a.match("ade")).to include("de")
  end

  it "returns terms added to the matcher after instantiation" do
    a = AhoCorasick.new("ab")
    a.insert("cd", "ef")
    expect(a.match("ab12cd12ef").to_set).to eq ["ab", "cd", "ef"].to_set
  end

  it "allows instantiation with an array of terms" do
    a = AhoCorasick.new(["ab"])
    expect(a.match("abcd")).to include("ab")
  end

  it "allows insert with an array of terms" do
    a = AhoCorasick.new("ab")
    a.insert(["cd"])
    expect(a.match("abcd")).to include("cd")
  end

  it "returns overlapping matched substrings correctly" do
    a = AhoCorasick.new(["cd", "d", "abce"])
    expect(a.match("abcd").to_set).to eq ["cd", "d"].to_set
  end
end
