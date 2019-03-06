module ActiveRecord
  module AliasAssociation
    extend ActiveSupport::Concern

    included do
      ActiveRecord::Associations::Builder::Association.extensions << AssociationBuilderExtension
    end

    module AssociationBuilderExtension
      def self.build(model, reflection)
        Array.wrap(reflection.options[:alias]).each do |new_name|
          model.send(:alias_association, new_name, reflection.name, reflection)
        end
      end

      def self.valid_options
        [:alias]
      end
    end

    module ClassMethods
      def alias_association(new_name, old_name, reflection = nil)
        reflection ||= reflect_on_association(old_name)

        raise NoMethodError, "undefined #{old_name} association for #{self}" unless reflection

        generated_association_methods.class_eval <<-CODE, __FILE__, __LINE__ + 1
          alias_method :#{new_name}, :#{old_name}
          alias_method :#{new_name}=, :#{old_name}=
        CODE

        case reflection.macro
        when :belongs_to, :has_one
          generated_association_methods.class_eval <<-CODE, __FILE__, __LINE__ + 1
            alias_method "build_#{new_name}",   "build_#{old_name}"
            alias_method "create_#{new_name}",  "create_#{old_name}"
            alias_method "create_#{new_name}!", "create_#{old_name}!"
            alias_method "reload_#{new_name}",  "reload_#{old_name}"
          CODE
        when :has_many, :has_and_belongs_to_many
          generated_association_methods.class_eval <<-CODE, __FILE__, __LINE__ + 1
            alias_method "#{new_name.to_s.singularize}_ids",  "#{old_name.to_s.singularize}_ids"
            alias_method "#{new_name.to_s.singularize}_ids=", "#{old_name.to_s.singularize}_ids="
          CODE
        else
          raise "Unsupported #{reflection.macro} reflection."
        end
      end

      def reflect_on_association(association)
        reflection = super(association)

        if reflection.nil? && method_defined?(association)
          reflection = super(instance_method(association).original_name)
        end

        reflection
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
