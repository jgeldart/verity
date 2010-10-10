module Verity
  module Core
    
    # Defines the core DSL for specifying validations.
    module DSL
      def self.included(klass)
        klass.class_eval do
          extend ClassMethods
          extend Verity::Predicates
        end
      end
    end

    module ClassMethods

      def method_missing(name, *args)
        begin
          super
        rescue NameError
          predicate = args[0]
          case name.to_s
          
          when /^(.*)_must$/
            attribute = $1.to_sym
            (validations[attribute][:positive] ||= []) << predicate
            true
          when /^(.*)_must_not$/
            attribute = $1.to_sym
            (validations[attribute][:negative] ||= []) << predicate
            true
          else
            raise
          end
        end
      end

    end
  end
end
