# AliMail

Ruby SDK for Aliyun Mail service. Check [Offical API document](https://help.aliyun.com/document_detail/29434.html?spm=a2c4g.11174283.6.587.57505e7aq8BDpg)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ali_mail'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ali_mail

## Configuration
Put this in your custom initializer file
```ruby
AliMail.configure do |config|
  config.access_key = 'your access key'
  config.access_secret  = 'your access secret'
  config.format = 'JSON' # default JSON
  config.click_trace = 1 # default 1
  config.reply_to_address = false # default false
end
```

## Usage
```
# Send plagin text
AliMail.send_text(
    from: 'your_send_address@example.com',
    to: ['email1@example.com', 'email2@example.com'],
    subject: 'Hello World From AliMail',
    text_body: 'mail content',
    options: { 'FromAlias' =>'Aliyun' } 
)

# Send HTML
AliMail.send_html(
    from: 'your_send_address@example.com',
    to: ['email1@example.com','email2@example.com'],
    subject: 'Hello World From AliMail',
    html_body: '<h1>mail content</h1>',
    options: { 'FromAlias' => 'Aliyun' }
)
```
Options can override settings in configuration. All Option list in office documemnt can be passed in
options, for detail:

https://help.aliyun.com/document_detail/29440.html

https://help.aliyun.com/document_detail/29444.html

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Tapas/ali_mail.
