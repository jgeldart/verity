module Verity
  module Core

    # Provides the core API for verifiable objects
    module Base
      def self.included(klass)
        klass.class_eval do
          extend ClassMethods
          include Verity::Core::DSL
        end
      end

      # Runs the validations on the instance and returns `false` if the
      # validations fail, or `true` otherwise.
      #
      # @return [TrueClass, FalseClass] Is the instance valid?
      # @api public
      def valid?
        valid = true
        self.class.validations.each_pair do | attribute, predicates |
          value = self.send(attribute)
          predicates[:positive].each do |predicate|
            valid &&= predicate.matches?(value)
          end if predicates.has_key?(:positive)
          predicates[:negative].each do |predicate|
            valid &&= !predicate.matches?(value)
          end if predicates.has_key?(:negative)
        end
        return valid
      end

    end

    module ClassMethods

      def self.extended(klass)
        klass.class_eval do
          @@validations = Hash.new { |hash, key| hash[key] = {} }
        end
      end

      # Returns a `Hash` of the validations defined on this class keyed by the
      # attribute name.
      #
      # @return [Hash] The validations defined on the class.
      # @api public
      def validations
        @@validations
      end

    end
  end
end
