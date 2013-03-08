module Verity::Predicates 
  # @private 
  class Be < Base

    def initialize(name, *args)
      @predicate_name = name + "?"
      super(*args)
    end

    def matches?(value)
      value.respond_to?(@predicate_name) && value.send(@predicate_name)
    end

    def positive_error_for(value)
      "must be #{@predicate_name}"
    end

    def negative_error_for(value)
      "must not be #{@predicate_name}"
    end
  end

end