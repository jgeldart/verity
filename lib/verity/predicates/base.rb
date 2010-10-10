module Verity
  module Predicates
    class Base

      attr_accessor :arguments

      def initialize(*args)
        configure(args)
      end

      def configure(*args)
        args = args.flatten
        if args[-1].is_a?(Hash)
          options = args[-1]
          args = args[(0..-2)]
        else
          options = {}
        end

        arguments = args

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
