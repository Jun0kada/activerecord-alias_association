require 'activerecord/alias_association/version'
require 'active_record'
require 'active_record/alias_association'
require 'active_record/extension/associations'

module ActiveRecord
  class Base
    include ActiveRecord::AliasAssociation
    include ActiveRecord::Extension::Associations
  end
end
