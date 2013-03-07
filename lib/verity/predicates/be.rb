module Verity::Predicates 
  # @private 
  class Be < Base

    def initialize(name, *args)
      @predicate_name = name + "?"
      super(*args)
      @defer = {}
      configure(args)
    end

    def matches?(value)
      value.respond_to?(@predicate_name) && value.send(@predicate_name)
    end
  end

end