# Foxycart Helpers

Several helpers for working with FoxyCart:

* Webhook endpoint for Datafeeds - https://wiki.foxycart.com/v/2.0/transaction_xml_datafeed

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'foxycart_helpers'
```

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install foxycart_helpers`

## Usage

### Transactional Datafeed Webhook

This helper creates a Rack endpoint to receive a POSTed XML data feed, it:

* Automatically URL decodes the POST.
* Decrypts with your API key `ENV['FOXYCART_API_KEY']`
* Parses the XML and presents it as a hash.

__Rack/Sinatra:__

```ruby
  # config.ru
  require 'foxycart_helpers/middleware'
  use Foxycart::Middleware
```

__Rails:__ This middleware is registered automatically.

```ruby
FoxycartHelpers.subscribe do |payload|
  puts payload
  # Do something with payload
  # You probably want to fire a background task
end
```

In Rails this could live at `config/initalizers/foxycart.rb`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rjocoleman/foxycart_helpers.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
