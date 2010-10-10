module Verity::Predicates
  # @private
  class Format < Base 
    def matches?(value)
      !!value.match(arguments[0])
    end
  end

  # Is `true` when the attribute matches the regular expression.
  #
  # @example 
  #   pin_must match(/\A\d{4}\Z/)
  # @api public
  def match(*args)
    Format.new(*args)
  end
end
