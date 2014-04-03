# TurkishSupport

A gem for Turkish character support for `String#upcase`, `String#downcase`, `String#capitalize` methods and their destructive versions like `String#upcase!`. In other words; this gem is a lighter version of the UnicodeUtils gem.

## Requirements
TurkishSupport uses refinements instead of monkey patching. So, you need to install at least v2.0.0 of Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'turkish_support'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turkish_support

## Usage

After installing the gem, you want to add a line before using Turkish supported version of the methods.

```ruby
  using TurkishSupport
```

If you want to see a simple [gist](https://gist.github.com/sbagdat/9964521) that shows how should you use it.

Now you can use your shiny new methods like below:

```ruby
  str = 'Bağcılar'
  str.upcase  #=> "BAĞCILAR"
  str         #=> "Bağcılar"

  str = "İSMAİL"
  str.downcase!   #=> "ismail"
  str             #=> "ismail"

  "merhaba".capitalize  #=> "Merhaba"
```


## Contributing

1. Fork it ( http://github.com/sbagdat/turkish_support/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
