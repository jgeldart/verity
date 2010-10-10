require 'verity/predicates/base'

module Verity
  module Predicates
    module Nil
      class Predicate < Verity::Predicates::Base 
        def matches?(value)
          value == nil
        end
      end

      # Is `true` when the attribute is `nil`.
      # 
      # @api public
      def be_nil
        Verity::Predicates::Nil::Predicate.new
      end
    end
  end
end
