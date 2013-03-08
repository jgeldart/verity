module Verity
  module Predicates
    class Base

      attr_accessor :arguments, :defer

      def initialize(*args)
        @defer = {}
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

        @arguments = args

        options.each_pair do |option,value|
          unless value.is_a?(Proc)
            set_named_argument(option, value)
          else
            @defer[option] = value
          end
        end
      end

      def satisfies?(record, value)
        @defer.each_pair do |option, block|
          unless block.arity < 1
            set_named_argument option, block.call(record)
          else
            set_named_argument option, block.call
          end
        end

        return matches?(value)
      end

      def matches?(value)
        false
      end

      def positive_error_for(value)
        "must be #{self.class.name.split('::').last.downcase}"
      end

      def negative_error_for(value)
        "must not be #{self.class.name.split('::').last.downcase}"
      end

      protected
      def set_named_argument(name, value)
        self.send("#{name}=",value)
      end

    end
  end
end
