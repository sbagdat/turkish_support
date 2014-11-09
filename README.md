# TurkishSupport

[![Gem Version](https://badge.fury.io/rb/turkish_support.svg)](http://badge.fury.io/rb/turkish_support)
[![Build Status](https://travis-ci.org/sbagdat/turkish_support.svg?branch=master)](https://travis-ci.org/sbagdat/turkish_support)
[![Gitter chat](https://badges.gitter.im/sbagdat/turkish_support.png)](https://gitter.im/sbagdat/turkish_support)

Turkish character support for some core ruby methods. This gem provide support for these methods: `String#upcase`,
`String#downcase`, `String#capitalize`, `String#swapcase`, `String#casecmp`, `String#match`, `Array#sort`, and their destructive versions like `Array#sort!` or `String#capitalize!`. It also gives you some bonus methods like `String#titleize`.

## Requirements

* Ruby  >= 2.0.0
* Rails >= 4.0.0

__Notice:__ TurkishSupport uses refinements instead of monkey patching. Refinements come with Ruby 2.0.0 as a new feature
and also, it is an experimental feature for now. If you want to more information about refinements, you can see the doc at [http://www.ruby-doc.org/core-2.0.0/doc/syntax/refinements_rdoc.html](http://www.ruby-doc.org/core-2.0.0/doc/syntax/refinements_rdoc.html)

## Installation

Add this line to your application's Gemfile:

    gem 'turkish_support'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turkish_support

## Usage Instructions

After the installation of the gem, you should follow these steps.

### Using with ruby

* Require the gem:

```ruby
  require TurkishSupport
```

* Add `using TurkishSupport` line to where you want to activate it.

```ruby
  using TurkishSupport
```

Example usage on the terminal:

```ruby
$ require 'turkish_support'     #=> true
$ using TurkishSupport          #=> main
$ 'içel'.upcase                 #=> "İÇEL"
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

Test.new.up_me('içel')  #=> "İÇEL"
```

### Using with rails

__Note:__ You don't need to require, because it is already required by the rails.

* In rails you must add `using TurkishSupport` line to the top of the scope, __not inside of any class or module__.

```ruby
  using TurkishSupport

  class SampleModel
    ...
  end
```

## Examples

Within the file that you added `using TurkishSupport` line; you can use the core methods like below:

__String#upcase__ and __String#upcase!__

```ruby
  str = 'Bağcılar'

  str.upcase    #=> "BAĞCILAR"
  str           #=> "Bağcılar"

  str.upcase!   #=> "BAĞCILAR"
  str           #=> "BAĞCILAR"
```

__String#downcase__ and __String#downcase!__

```ruby
  str = 'İSMAİL'
  str.downcase    #=> "ismail"
```

__String#capitalize__ and __String#capitalize!__

```ruby
  str = 'türkÇE desteĞİ'
  str.capitalize    #=> "Türkçe desteği"
```

__String#swapcase__ and __String#swapcase!__
```ruby
  'TuğÇE'.swapcase    #=> "tUĞçe"
```

__String#casecmp__
```ruby
  'sıtKI'.casecmp('SITkı')     #=> 0
```

__String#match__

```ruby
  'Aşağı'.match(/\w+/)                         #=> #<MatchData "Aşağı">
  'Aşağı Ayrancı'.match(/^\w+\s\w+$/)          #=> #<MatchData "Aşağı Ayrancı">
  'aüvvağğ öövvaağ'.match(/^[a-z]+\s[a-z]+$/)  #=> #<MatchData "aüvvağğ öövvaağ">
  'BAĞCIlar'.match(/[A-Z]+/)                   #=> #<MatchData "BAĞCI">
  'Aşağı Ayrancı'.match(/\W+/)                 #=> #<MatchData "">
```

__Array#sort__ and __Array#sort!__

```ruby
  %w(iki üç dört ılık iğne iyne).sort
  #=> ["dört", "ılık", "iğne", "iki", "iyne", "üç"]
```

__String#titleize__ and __String#titleize!__

These methods are not core methods of ruby, but they are accepted as useful in most situations.

```ruby
  'türkÇE desteĞİ'.titleize           #=> "Türkçe Desteği"

  # Parenthesis, quotes, etc. support
  "rUBY roCkS... (really! 'tRUSt' ME)".titleize          #=> "Ruby Rocks... (Really! 'Trust' Me)"

  # If you don't want to capitalize conjuctions, simply pass a false value as a parameter
  "kerem VE aslı VeYa leyla İlE mecnun".titleize(false)  #=> "Kerem ve Aslı veya Leyla ile Mecnun"
```

__Important Note:__ If you also want to use original set of the core methods in the same scope, you can use `send` method like this:

```ruby
  str = 'Bağcılar'
  str.send(:upcase)  #=> "BAğCıLAR"
```

## Contributing

1. Fork it ( http://github.com/sbagdat/turkish_support/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
