[![Gem Version](https://badge.fury.io/rb/ruby_magic_link.svg)](https://badge.fury.io/rb/ruby_magic_link)
![CI](https://github.com/igorkorepanov/ruby_magic_link/actions/workflows/main.yml/badge.svg)

# RubyMagicLink

RubyMagicLink: A gem crafted for the secure generation of tokens, ensuring the safe transmission of data within your Ruby application. Useful for creating magic links—single-use URLs empowering users to perform actions without a password.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_magic_link'
```

And then execute:

```bash
bundle install
```

Or install it manually using:

```bash
gem install ruby_magic_link
```

## Usage
### Configuration

For Rails applications, create an initializer file in the `config/initializers` directory.

```ruby
# config/initializers/ruby_magic_link.rb

RubyMagicLink.setup do |config|
  config.secret_key = 'your_secret_key'
end
```

Replace `your_secret_key` with a strong secret key. Keep this key confidential and do not expose it in your public repositories.

To generate a secret key, run the following rake task:

```bash
bundle exec rake ruby_magic_link:generate_key
```

### Simple Example

Encode your data:

```ruby
payload = {
  user_id: 123_456,
  action: :authenticate
}
encrypted_data = RubyMagicLink::Token.create(payload, expires_in: Time.now.to_i + 3600)
url = "https://example.com/magic_links?data=#{encrypted_data}"

# Send the generated URL in an email or through other communication channels.
```

Decode your data:

```ruby
class MagicLinksController < ApplicationController
  def index
    token = RubyMagicLink::Token.decode(params[:data])
    if token.valid? && token.payload['action'] == 'authenticate'
      sign_in(:user, token.payload['user_id'])
      redirect_to home_path
    end
  end
end
```


## License

Copyright (c) 2024 Igor Korepanov

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.