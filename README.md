# Activerecord::AliasAssociation

[![Build Status](https://travis-ci.org/Jun0kada/activerecord-alias_association.svg?branch=master)](https://travis-ci.org/Jun0kada/activerecord-alias_association)

ActiveRecord Association alias
`belongs_to`, `has_one`, `has_many`, `has_and_belongs_to_many`

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
  belongs_to :team, alias: [:organization, :club]

  has_one :profile, alias: :info

  has_many :posts, alias: :articles

  has_many :post_images, through: :users, source: :images, alias: :article_images

  has_and_belongs_to_many :tags, alias: :categories

  # or

  belongs_to :team
  alias_association :organization, :team

  has_one :profile
  alias_association :info, :profile

  has_many :posts
  alias_association :articles, :posts

  has_many :post_images, through: :users, source: :images
  alias_association :article_images, :post_images

  has_and_belongs_to_many :tags
  alias_association :categories, :tags
end
```

### Accessors & Constructors

```ruby
user = User.first

# belongs_to, has_one
user.organization
user.organization=
user.build_organization
user.create_organization
user.create_organization!
user.reload_organization

# nas_many, has_and_belongs_to_many
user.posts
user.posts=
user.post_ids
user.post_ids=
```

### ActiveRecord QueryMethods

```ruby
User.includes(:organization, :posts, :tags)
User.preload(:organization, :posts, :tags)
User.eager_load(:organization, :posts, :tags)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/activerecord-alias_association. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Activerecord::AliasAssociation project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/activerecord-alias_association/blob/master/CODE_OF_CONDUCT.md).
