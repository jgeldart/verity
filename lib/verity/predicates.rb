require 'verity/predicates/nil'
require 'verity/predicates/length'

module Verity
  module Predicates
    def self.extended(klass)
      klass.class_eval do
        extend Verity::Predicates::Nil
        extend Verity::Predicates::Length
      end
    end
  end
end
