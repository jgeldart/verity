module Verity::Predicates
  # @private
  class Present < Base 
    def matches?(value)
      !(value.nil? || (value.respond_to?(:empty?) && value.empty?))
    end
  end

  # Is `true` when the attribute is `present`.
  # 
  # @api public
  def be_present
    Present.new
  end
end
