# Bub

bub is a command line tool for Bitbucket (only git) to create and remove repository.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bub'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bub

## Usage

### Create
create your bitbucket private repositories.

```sh
$ cd path/to/repo-name
$ bub create
```

### Delete
remove your bitbucket private repositories.

```sh
$ cd path/to/repo-name
$ bub delete
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec bub` to use the code located in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bub/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
