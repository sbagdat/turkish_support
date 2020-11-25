# TurkishSupport [![Gem Version](https://badge.fury.io/rb/turkish_support.svg)](https://badge.fury.io/rb/turkish_support) [![Build Status](https://travis-ci.org/sbagdat/turkish_support.svg?branch=master)](https://travis-ci.org/sbagdat/turkish_support) [![Code Climate](https://codeclimate.com/github/sbagdat/turkish_support/badges/gpa.svg)](https://codeclimate.com/github/sbagdat/turkish_support)

Turkish character support for core ruby methods. This gem provides support nearly all `String` methods,
such as `String#split`, `String#match`, `String#gsub`. It also provides support for `Array#sort`and some 
bonus methods like `String#titleize`.

## Requirements
* Ruby  >= 2.7.0
* Rails >= 6.0.0

* [Installation](#installation)
* [Usage](#usage)
  * [Using with ruby](#using-with-ruby)
  * [Using with ruby on rails](#using-with-ruby-on-rails)
* [String Methods](#string-methods)
  * [#<=>](#-spaceship)
  * [#>](#----comparisons)
  * [#>=](#----comparisons)
  * [#<](#----comparisons)
  * [#<=](#----comparisons)
  * [#[] and #[]=](#-and-)
  * [capitalize](#capitalize-and-capitalize)
  * [casecmp](#casecmp)
  * [downcase](#downcase-and-downcase)
  * [gsub](#gsub-and-gsub)
  * [index](#index)
  * [match](#match)
  * [partition](#partition)
  * [rpartition](#rpartition)
  * [rindex](#rindex)
  * [scan](#scan)
  * [slice](#slice-and-slice)
  * [split](#split)
  * [sub](#sub-and-sub)
  * [swapcase](#swapcase-and-swapcase)
  * [titleize](#titleize-and-titleize)
  * [upcase](#upcase-and-upcase)
* [Array Methods](#array-methods)
  * [sort](#sort-and-sort)

## Installation
Add this line to your application's Gemfile:

```
gem 'turkish_support'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install turkish_support
```

## Usage

After the installation of the gem, you should follow these steps.

### Using with ruby

* Require the gem:

```ruby
  require 'turkish_support'
```

* Add `using TurkishSupport` line to a class or a module.

Example usage inside a class:

```ruby
require 'turkish_support'

class CanSpeakInTurkish
  using TurkishSupport

  def split_me_up(string, sep)
    string.split(sep)
  end
end

CanSpeakInTurkish.new.split_me_up('çar çarı çarşı', 'ç')
# ['ar', 'arı', 'arşı']
```

### Using with ruby on rails

__Note:__ You don't need to require, because it is already required by the rails.

* You must add `using TurkishSupport` line to the top of the scope.

```ruby
  using TurkishSupport

  class TopModel < ApplicationRecord
    # your code goes here
  end
```

* If you want to use TurkishSupport with a custom class or a module that is not inherited from any rails tie, 
you must add `using TurkishSupport` line to the class or module.

```ruby
  class CustomClass
    using TurkishSupport

    # your code goes here
  end
```

## String Methods

### <=> (spaceship)
```ruby
  'Cahit' <=> 'Çağla' # => -1
  'Sıtkı' <=> 'Ömer'  # =>  1
  'Eren'  <=> 'Eren'  # =>  0
  'c'     <=> 'ca'    # => -1
```

### <, <=, >, >= (comparisons)
```ruby
  'd'   >  'ç'     # => true
  'aha' >= 'ağa'   # => true
  'd'   <  'ç'     # => false
  'ağa' <= 'aha'   # => true
```

### [] and []=
```ruby
  'Türkiye Cumhuriyeti'[/\w+/] # => "Türkiye"
  'Çetin'[/[a-ğ]+/i]           # => "Çe"
```

### capitalize and capitalize!
```ruby
  str = 'türkÇE desteĞİ'

  str.capitalize    # => "Türkçe desteği"
  str.capitalize!   # => "Türkçe desteği"
```

### casecmp
```ruby
  'sıtKI'.casecmp('SITkı')     # => 0
```

### downcase and downcase!
```ruby
  str = 'İSMAİL'

  str.downcase    # => "ismail"
  str.downcase!   # => "ismail"
```

### gsub and gsub!
```ruby
  'ağa paşa ağa'.gsub(/\b[a-h]+\b/, 'bey') # => "bey paşa bey"
```

### index
```ruby
  '?ç-!+*/-ğüı'.index(/\w+/)        # => 1
  '?ç-!+*/-ğüı'.index(/[a-z]+/, 2)  # => 8
```

### match
```ruby
  'Aşağı'.match(/\w+/)
  # => #<MatchData "Aşağı">

  'Aşağı Ayrancı'.match(/^\w+\s\w+$/)
  # => #<MatchData "Aşağı Ayrancı">

  'aüvvağğ öövvaağ'.match(/^[a-z]+\s[a-z]+$/)
  # => #<MatchData "aüvvağğ öövvaağ">

  'BAĞCIlar'.match(/[A-Z]+/)
  # => #<MatchData "BAĞCI">

  'Aşağı Ayrancı'.match(/\W+/)
  # => #<MatchData "">
```

### partition
```ruby
  'Bağlarbaşı Çarşı'.partition(/\W+/) # => ["Bağlarbaşı", " ", "Çarşı"]
```

### rpartition
```ruby
  'Bağlarbaşı Çarşı Kalabalık'.rpartition(/\W+/)
  # => ["Bağlarbaşı Çarşı", " ", "Kalabalık"]
```

### rindex
```ruby
  'şç-!+*/-ğüı'.rindex(/\w+/, 7)  # => 1
```

### scan
```ruby
  'Bağlarbaşı Çarşı Kalabalık'.scan(/[a-z]+/i)
  # => ["Bağlarbaşı", "Çarşı", "Kalabalık"]
```


### slice and slice!
```ruby
  'Duayen'.slice(/[^h-ö]+/) # => "Duaye"
```

### split
```ruby
  'Bağlarbaşı Çarşı Kalabalık'.split(/\W+/)
  # => ["Bağlarbaşı", "Çarşı", "Kalabalık"]

  'Bağlarbaşı Çarşı Kalabalık'.split(/[ç-ş]+/)
  # => ["Ba", "a", "ba", " Ça", " Ka", "aba"]
```

### sub and sub!
```ruby
  'ağapaşaağa'.sub(/[a-h]+/, 'bey')  # => "beypaşaağa"
```

### swapcase and swapcase!
```ruby
  'TuğÇE'.swapcase    # => "tUĞçe"
  'TuğÇE'.swapcase!   # => "tUĞçe"
```

### titleize and titleize!
*These methods are not core methods of ruby, but they are accepted as useful in most situations.*
```ruby
  'türkÇE desteĞİ'.titleize           # => "Türkçe Desteği"
  'türkÇE desteĞİ'.titleize!          # => "Türkçe Desteği"

  # Parenthesis, quotes, etc. support
  "rUBY roCkS... (really! 'tRUSt' ME)".titleize
  # => "Ruby Rocks... (Really! 'Trust' Me)"
```

### upcase and upcase!

```ruby
  str = 'Bağcılar'

  str.upcase    # => "BAĞCILAR"
  str           # => "Bağcılar"

  str.upcase!   # => "BAĞCILAR"
  str           # => "BAĞCILAR"
```

## Array Methods

### sort and sort!

```ruby
  %w(iki üç dört ılık iğne iyne).sort
  # => ["dört", "ılık", "iğne", "iki", "iyne", "üç"]
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sbagdat/turkish_support. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/sbagdat/turkish_suppport/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TurkishSupport project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct]
