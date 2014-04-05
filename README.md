# TurkishSupport

[![Gem Version](https://badge.fury.io/rb/turkish_support.svg)](http://badge.fury.io/rb/turkish_support)

Turkish character support for some standard Ruby methods. This gem provide support for these methods:
* `String#upcase`
* `String#upcase!`
* `String#downcase`
* `String#downcase!`
* `String#capitalize`
* `String#capitalize!`
* `String#swapcase`
* `String#swapcase!`
* `String#casecmp`

Also gives you some new methods like:
* `String#titleize`

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

* You need require it.

__Note:__ If you are using a framework like Rails, you don't need to require, because it is already required by the framework.

```ruby
  require TurkishSupport
```

* Add `using TurkishSupport` line to the top of the scope, __not inside of any class or module__.

```ruby
  using   TurkishSupport
```

## Examples

Within the file which you added `using TurkishSupport` line to the top of the scope; you can use core methods like below:

```ruby
  str = 'Bağcılar'
  str.upcase  #=> "BAĞCILAR"
  str         #=> "Bağcılar"

  str = "İSMAİL"
  str.downcase!   #=> "ismail"
  str             #=> "ismail"

  "merhaba".capitalize  #=> "Merhaba"
```

__Note:__ If you also want to use original set of the core methods in the same scope, you can use `send` method like this:

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
