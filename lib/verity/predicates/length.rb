module Verity::Predicates
  # @private
  class Length < Base 
    attr_accessor :less_than
    def matches?(value)
      if less_than
        value.length < less_than
      end
    end
  end

  # Is `true` when the attribute has a length within the given
  # range. 
  #
  # @example 
  #   login_must have_length(:greater_than => 4)
  # @api public
  def have_length(options = {})
    Length.new(options)
  end
end
