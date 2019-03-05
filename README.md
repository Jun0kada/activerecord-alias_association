# Activerecord::AliasAssociation

[![Build Status](https://travis-ci.org/Jun0kada/activerecord-alias_association.svg?branch=master)](https://travis-ci.org/Jun0kada/activerecord-alias_association)

ActiveRecord Association alias
`belongs_to`, `has_one`, `has_many`, `has_many through`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-alias_association'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-alias_association

## Usage

```ruby
class User < ActiveRecord::Base
  belongs_to :team, alias: :organization

  has_one :profile, alias: :info

  has_many :posts, alias: :articles

  has_many :post_images, through: :users, source: :images, alias: :article_images

  # or

  belongs_to :team
  alias_association :organization, :team

  has_one :profile
  alias_association :info, :profile

  has_many :posts
  alias_association :articles, :posts

  has_many :post_images, through: :users, source: :images
  alias_association :article_images, :post_images
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/activerecord-alias_association. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Activerecord::AliasAssociation project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/activerecord-alias_association/blob/master/CODE_OF_CONDUCT.md).
