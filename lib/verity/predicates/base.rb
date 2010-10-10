module Verity
  module Predicates
    class Base

      def initialize(options = {})
        options.each_pair do |option,value|
          self.send("#{option}=",value)
        end
      end

      def matches?(value)
        false
      end

      def positive_error_for(value)
        "is invalid."
      end

      def negative_error_for(value)
        "is invalid."
      end

    end
  end
end
