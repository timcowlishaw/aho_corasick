Aho-Corasick string matching
============================

The [Aho-Corasick string matching algorithm](http://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_string_matching_algorithm) will find all instances of a set of terms that are substrings of a certain string in constant time with respect to the length of the string. It does this by pre-building a NFA-like structure which it uses to efficiently parse the string for all the terms in the set to be matched against.

Our implementation is written in pure Ruby, and is used like so:

```ruby
require 'aho_corasick'
matcher = AhoCorasick.new("woodchuck", "chuck", "could")
matcher.match("How much wood would a woodchuck chuck if a woodchuck could chuck wood.")
#=> ["woodchuck", "chuck", "woodchuck", "could", "chuck"]
```

You can insert additional terms into the matcher after instantiation, however each call to insert takes linear time with respect to the total number of terms to be matched against. You can call insert passing multiple terms to mitigate against this:

```ruby
matcher.insert("would", "wood")
matcher.match("How much wood would a woodchuck chuck if a woodchuck could chuck wood.")
#=> ["wood", "would", "wood", "woodchuck", "chuck", "wood", "woodchuck", "could", "chuck", "wood"] 
```

To install: ``gem install aho_corasick`` or add ``gem "aho_corasick"`` to your Gemfile. We've tested it with Ruby 1.9.2, but there's nothing in there that should stop it working with any other Ruby. If you find any bugs, let us know - Feature requests and pull requests also welcome!

