module Verity::Predicates
  # @private
  class Empty < Base
    def matches?(value)
      value.nil? || (value.respond_to?(:empty?) && value.empty?)
    end
  end

  # Is `true` when the attribute is `empty`.
  #
  # @api public
  def be_empty
    Empty.new
  end
end
