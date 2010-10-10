require 'verity/predicates/base'

module Verity
  module Predicates
    module Length
      class Predicate < Verity::Predicates::Base 
        attr_accessor :less_than
        def matches?(value)
          if less_than
            value.length < less_than
          end
        end
      end

      def have_length(options = {})
        Verity::Predicates::Length::Predicate.new(options)
      end
    end
  end
end
