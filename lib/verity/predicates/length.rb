module Verity::Predicates
  # @private
  class Length < Base 
    attr_accessor :exactly, :less_than, :at_least, :greater_than, :at_most
    def matches?(value)
      valid = true
      if [String, Symbol].include?(value.class)
        length = value.to_s.length
        valid &&= length == exactly if exactly
        valid &&= length < less_than if less_than
        valid &&= length > greater_than if greater_than
        valid &&= length >= at_least if at_least
        valid &&= length <= at_most if at_most
      else
        valid = false
      end
      return valid
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
