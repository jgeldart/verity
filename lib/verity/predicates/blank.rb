module Verity::Predicates
  # @private
  class Blank < Base
    def matches?(value)
      value == nil || (value.to_s.strip == "")
    end
  end

  # Is `true` when the attribute is `nil` or an empty `String`.
  #
  # @example
  #   login_must_not be_blank
  # @api public
  def be_blank
    Blank.new
  end
end
