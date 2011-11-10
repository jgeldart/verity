module Verity::Predicates 
  # @private 
  class Equal < Base
    attr_accessor :to 
    def matches?(value)
      valid = true
      valid = value == to if to
      return valid
    end
  end

  def be_equal(options = {})
    Equal.new(options)
  end
end
