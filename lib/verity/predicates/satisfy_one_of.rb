module Verity::Predicates 
  # @private 
  class SatisfiesOneOf < Base 
    def satisfies?(record, value)
      super(record, value)
      valid = false 
      arguments.each do |predicate|
        valid ||= predicate.satisfies?(record, value)
      end
      return valid
    end
  end

  def satisfy_one_of(*args)
    SatisfiesOneOf.new(*args)
  end
end
