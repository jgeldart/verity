module Verity
  module Core

    # Provides the core API for verifiable objects
    module Base
      def self.included(klass)
        klass.class_eval do
          extend ClassMethods
        end
      end

      # Runs the validations on the instance and returns `false` if the
      # validations fail, or `true` otherwise.
      #
      # @return [TrueClass, FalseClass] Is the instance valid?
      # @api public
      def valid?
        true
      end

    end

    module ClassMethods

      def self.extended(klass)
        klass.class_eval do
          @@validations = {}
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
