module Verity::Predicates
  # @private
  class Nil < Base 
    def matches?(value)
      value == nil
    end
  end

  # Is `true` when the attribute is `nil`.
  # 
  # @example
  #   login_must_not be_nil
  # @api public
  def be_nil
    Nil.new
  end
end
