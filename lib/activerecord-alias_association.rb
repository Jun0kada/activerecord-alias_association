require 'activerecord/alias_association/version'
require 'active_record'
require 'active_record/alias_association'

module ActiveRecord
  class Base
    include ActiveRecord::AliasAssociation
  end
end
