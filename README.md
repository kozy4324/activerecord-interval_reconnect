# ActiveRecord::IntervalReconnect

ActiveRecord extension to reconnect connections at a fixed interval.

Provides interval-based reconnection for ActiveRecord connections. Helps handle RDS failover scenarios by periodically refreshing connections on checkout.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add activerecord-interval_reconnect
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install activerecord-interval_reconnect
```

## Usage

Add reconnection_interval to a connection configuration in database.yml. When a connection is checked out from the pool, ActiveRecord will reconnect if the specified number of seconds has passed since the last reconnect.

```
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000
  reconnection_interval: 15
```

In this example, if more than 15 seconds have elapsed since the last reconnect, the next checkout will trigger `reconnect!`. If `reconnection_interval` is not specified, nothing happens.

- Reconnection only occurs on checkout, so it will not interrupt an ongoing transaction.
- If you have multiple database connections, only those with `reconnection_interaval` set are affected.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kozy4324/activerecord-interval_reconnect.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
