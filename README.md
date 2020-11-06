# TurkishSupport

[![Gem Version](https://badge.fury.io/rb/turkish_support.svg)](http://badge.fury.io/rb/turkish_support)
[![Build Status](https://travis-ci.org/sbagdat/turkish_support.svg?branch=master)](https://travis-ci.org/sbagdat/turkish_support)

Turkish character support for core ruby methods. This gem provides support nearly all `String` methods, such as `String#upcase`, `String#downcase`, `String#match`, `String#gsub`. It also provides support for `Array#sort`and some bonus methods like `String#titleize`.

## Requirements

* Ruby  >= 2.7.0
* Rails >= 6.0.0

__Notice:__ TurkishSupport uses __refinements__ instead of monkey patching.

* [Installation](#installation)
* [Usage](#usage)
  * [Using with ruby](#using-with-ruby)
  * [Using with ruby on rails](#using-with-ruby-on-rails)
  * [Using Core Methods](#using-core-methods)
* [String Methods](#string-methods)
  * [#<=>](#-spaceship)
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

    gem 'turkish_support'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turkish_support

## Usage

After the installation of the gem, you should follow these steps.

### Using with ruby

* Require the gem:

```ruby
  require 'turkish_support'
```

* Add `using TurkishSupport` line to where you want to activate it.

```ruby
  using TurkishSupport
```

Example usage inside a class:

```ruby
require 'turkish_support'

class Test
  using TurkishSupport
  def up_me(str)
    str.upcase
  end
end

Test.new.up_me('içel')  # => "İÇEL"
```

### Using with ruby on rails

__Note:__ You don't need to require, because it is already required by the rails.

* You must add `using TurkishSupport` line to the top of the scope.

```ruby
  using TurkishSupport

  class SampleModel < ActiveRecord::Base
    ...
  end
```

* If you want to use TurkishSupport with a custom class or a module that is not inherited from any rails tie, you must add `using TurkishSupport` line to the class or module.

```ruby
  class CustomClass
    using TurkishSupport

    ...
  end
```

### Using Core Methods

If you want to use original set of the core methods in the same scope, you can use `Object#public_send`:

```ruby
  str = 'Bağcılar'
  str.public_send(:upcase)  # => "BAğCıLAR"
```

## String Methods

### <=> (spaceship)
```ruby
  'Cahit' <=> 'Çağla' # => -1
  'Sıtkı' <=> 'Ömer'  # =>  1
  'Eren'  <=> 'Eren'  # =>  0
  'c'     <=> 'ca'    # => -1
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
 'ağapaşaağa'.gsub(/[a-h]+/, 'bey')
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

  # If you don't want to capitalize conjuctions,
  # simply pass a false value as parameter
  "kerem VE aslı VeYa leyla İlE mecnun".titleize(false)
  # => "Kerem ve Aslı veya Leyla ile Mecnun"
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

## Contributing

1. Fork it ( http://github.com/sbagdat/turkish_support/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
