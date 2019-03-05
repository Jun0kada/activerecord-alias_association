module ActiveRecord
  module AliasAssociation
    extend ActiveSupport::Concern

    included do
      ActiveRecord::Associations::Builder::Association.extensions << AssociationBuilderExtension
    end

    module AssociationBuilderExtension
      def self.build(model, reflection)
        Array.wrap(reflection.options[:alias]).each do |new_name|
          model.send(:alias_association, new_name, reflection.name)
        end
      end

      def self.valid_options
        [:alias]
      end
    end

    module ClassMethods
      def alias_association(new_name, old_name)
        generated_association_methods.class_eval <<-CODE, __FILE__, __LINE__ + 1
          alias_method :#{new_name}, :#{old_name}
          alias_method :#{new_name}=, :#{old_name}=
        CODE
      end

      def _reflect_on_association(association)
        reflection = super(association)

        if reflection.nil? && method_defined?(association)
          reflection = super(instance_method(association).original_name)
        end

        reflection
      end
    end
  end
end
