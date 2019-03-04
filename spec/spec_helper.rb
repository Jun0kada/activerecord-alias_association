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

class User < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
end

class Post < ActiveRecord::Base
end

if ActiveRecord.version >= Gem::Version.new('5.2.0')
  ActiveRecord::MigrationContext.new(File.expand_path('../db/migrate', __FILE__)).up
else
  ActiveRecord::Migrator.migrate File.expand_path('../db/migrate', __FILE__), nil
end
