require 'spec_helper'

describe "AhoCorasick" do
  it "returns matched substrings" do
    a = AhoCorasick.new(["ab"])
    a.match("abcde").should include("ab")
  end

  it "returns multiple matched substrings" do
    a  = AhoCorasick.new(["ab", "cd"])
    a.match("cd123ab").to_set.should == ["ab", "cd"].to_set
  end

  it "returns overlapping matched substrings" do
    a = AhoCorasick.new(["ab", "bc"])
    a.match("abc").to_set.should == ["ab", "bc"].to_set
  end

  it "does not return unmatched substrings" do
    a = AhoCorasick.new(["ab"])
    a.match("abc").should_not include("bc")
  end

end
