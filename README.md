# Foxycart Helpers

Several helpers for working with FoxyCart:

* Webhook endpoint for Datafeeds - https://wiki.foxycart.com/v/2.0/transaction_xml_datafeed
* HMAC Product Verification - https://wiki.foxycart.com/v/2.0/hmac_validation
* Link href builder (with support for Product Verification)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'foxycart_helpers'
```

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install foxycart_helpers`


## Setup

The datafeed endpoint defaults to '/foxycart_processor'. If your app is at `https://example.com/` then you should set your datafeed URL in FoxyCart to `https://example.com/foxycart_processor`

`ENV['FOXYCART_API_KEY']` should be set to your FoxyCart API key (available from the FoxyCart Admin area).

Or you can override these in configuration:

```ruby
# In an appropriate initializer e.g. /config/initializers/foxycart.rb
FoxycartHelpers.configure do |config|
  config.mount_point = '/some/other/path'
  config.api_key = 'foobarbat'
  config.url = 'https://example.foxycart.com/'
  config.auto_encode_hrefs = true # automatically use product verification on generated hrefs
end
```


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

Then:

```ruby
FoxycartHelpers.subscribe do |payload|
  puts payload
  # Do something with payload
  # You probably want to fire a background task
end
```

In Rails this could live at `config/initalizers/foxycart.rb`


### HMAC Product Verification

This helper HMAC encodes values for use with the Product Verification feature of FoxyCart, it:

* Encodes with your API key `ENV['FOXYCART_API_KEY']`
* Can return both full string for direct replacement of existing names and values or just the hash.
* Includes Rails view helpers.

* `code` = Product code (`sku123`)
* `name` = Value of name field in the HTML (`name`)
* `value` = Value (or initial value) of the input etc (`Cool Example`)

See the [FoxyCart docs](https://wiki.foxycart.com/v/2.0/hmac_validation) for more information on `code`, `name` and `value`.

__Standalone:__

```ruby
FoxycartHelpers::ProductVerification.encode code, name, value
# => "54a534ba0afef1b4589c2f77f9011e27089c0030a8876ec8f06fca281fedeb89"
FoxycartHelpers::ProductVerification.encoded_name code, name, value
# => "name||54a534ba0afef1b4589c2f77f9011e27089c0030a8876ec8f06fca281fedeb89"
```

__Rails:__

In your views:

```ruby
<%= foxycart_encode 'sku123', 'name', 'Cool Example' %>
# => "54a534ba0afef1b4589c2f77f9011e27089c0030a8876ec8f06fca281fedeb89"
<%= foxycart_encoded_name 'sku123', 'name', 'Cool Example' %>
# => "name||54a534ba0afef1b4589c2f77f9011e27089c0030a8876ec8f06fca281fedeb89"
```

## Link Href builder

Creates cart hrefs (encoded or plain) given for a store URL.

Params are:

* `name` (required always)
* `price` (required always)
* `code` (required if product validation is used)
* `opts` a hash, supported values here: https://wiki.foxycart.com/v/2.0/cheat_sheet

```ruby
# plain
FoxycartHelpers::Link.href 'Cool Example', '10', nil, { color: 'red' }
# => "https://example.foxycart.com/cart?name=Cool+Example&price=10&color=red"

# encoded
FoxycartHelpers::Link.href 'Cool Example', '10', 'sku123', { color: 'red' }
=> "https://example.foxycart.com/cart?name=Cool%20Example||54a534ba0afef1b4589c2f77f9011e27089c0030a8876ec8f06fca281fedeb89&price=10||a36dd6bcf3587676c9926d389c87cda3bf0033e6c40e0cc7124edc38409f16a9&code=sku123||dc2a524b987ee5e18af483c1a9e2d333f50eae7d8ed417b8b39442dff4c3ab82&color=red||a81b7a17e4f142ae99678fba7e479734785914953a07a42a0dbd44e145775ae9"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rjocoleman/foxycart_helpers.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
