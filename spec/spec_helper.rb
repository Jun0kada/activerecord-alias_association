$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'

Bundler.require

require 'active_record'

ActiveRecord::Base.configurations[:test] = {
  adapter: 'sqlite3',
  database: ':memory:'
}

ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[:test])

class Team < ActiveRecord::Base
  has_many :users, alias: :members
  alias_association :team_members, :users

  has_many :comments, through: :users, source: :comments, alias: :member_comments
  alias_association :team_member_comments, :comments
end

class User < ActiveRecord::Base
  has_many :comments

  has_one :comment, alias: :review
  alias_association :one_comment, :comment

  belongs_to :team, alias: :club
  alias_association :organization, :team
end

class Comment < ActiveRecord::Base
  belongs_to :user, alias: [:owner, :commentor]
end

ActiveRecord::Migration.verbose = false

if ActiveRecord.version >= Gem::Version.new('5.2.0')
  ActiveRecord::MigrationContext.new(File.expand_path('../db/migrate', __FILE__)).up
else
  ActiveRecord::Migrator.migrate File.expand_path('../db/migrate', __FILE__), nil
end
