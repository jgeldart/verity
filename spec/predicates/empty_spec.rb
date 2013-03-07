require 'spec_helper'

module Verity::Predicates 
  describe Empty do

    it 'matches nil' do
      expect(subject.matches?(nil)).to be_true
    end

    it 'matches empty strings' do
      expect(subject.matches?('')).to be_true
    end

    it 'matches empty collections' do
      expect(subject.matches?([])).to be_true
    end

    it 'does not match other objects' do
       expect(subject.matches?('non-empty string')).to be_false
    end

  end

end

describe 'empty predicate' do

  before :all do
    class User
      verifiable

      attr_accessor :data
      data_must_not be_empty
    end
  end

  subject { User.new }

  context 'with empty data' do

    before do
      subject.data = []
    end

    it { should_not be_valid }
  end
 
   context 'with some data' do

    before do 
      subject.data = ['stuff']
    end 

    it { should be_valid }
  end

end