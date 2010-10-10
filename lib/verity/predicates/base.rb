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

    end
  end
end
