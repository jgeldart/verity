# Provides the core API for verifiable objects.
module Verity::Core::Base
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
    clear_validation_error_hash
    self.class.validations.each_pair do | attribute, predicates |
      value = self.send(attribute)

      predicates[:positive].each do |predicate|
        write_error(attribute, predicate.positive_error_for(value)) unless predicate.satisfies?(self, value)
      end if predicates.has_key?(:positive)

      predicates[:negative].each do |predicate|
        write_error(attribute, predicate.negative_error_for(value)) if predicate.satisfies?(self, value)
      end if predicates.has_key?(:negative)

    end
    return validation_errors.empty?
  end

  # A `Hash` of validation errors obtained after running the validations
  # defined using `#valid?`. The `Hash` is keyed by attribute where each 
  # value is an `Array` of `String`s.
  #
  # @example 
  #   obj.validation_errors  #=> { :someattr => [ "is required." ] }
  # @return [Hash{Symbol => Array<String>}] A `Hash` of error messages keyed by attribute name.
  # @api public
  def validation_errors
    lazy_validation_error_hash
  end

  protected
  def lazy_validation_error_hash
    @validation_errors ||= empty_validation_error_hash
  end
    
  def empty_validation_error_hash
    Hash.new { |h,k| h[k] =[] }
  end

  def clear_validation_error_hash
    @validation_errors = empty_validation_error_hash
  end

  def write_error(attribute, message)
    self.lazy_validation_error_hash[attribute] << message
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

