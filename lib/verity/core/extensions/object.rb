# Provides a class method on `Object` for making classes verifiable.
module Verity::Core::Extensions::ObjectExtensions

  # Makes a class verifiable, adding the DSL to the class and the core API
  # to its instances. 
  #
  # @example
  #   Hash.verifiable #=> true
  #
  # @api public
  def verifiable
    include Verity::Core::Base
    true
  end
end

class Object
  extend Verity::Core::Extensions::ObjectExtensions
end
