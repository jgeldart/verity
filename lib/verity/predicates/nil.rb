require 'verity/predicates/base'

module Verity
  module Predicates
    module Nil
      class Predicate < Verity::Predicates::Base 
        def matches?(value)
          value == nil
        end
      end

      def be_nil
        Verity::Predicates::Nil::Predicate.new
      end
    end
  end
end
