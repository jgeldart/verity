require 'spec_helper'

module Verity::Predicates 
  describe Present do

    it 'does not match nil' do
      expect(subject.matches?(nil)).to be_false
    end

    it 'does not match empty strings' do
      expect(subject.matches?('')).to be_false
    end

    it 'matches non-empty strings' do
      expect(subject.matches?('non-empty string')).to be_true
    end

    it 'does not match empty arrays' do
      expect(subject.matches?([])).to be_false
    end

    it 'matches non-empty arrays' do
      expect(subject.matches?([:stuff])).to be_true
    end

    it 'does not match empty hashes' do
      expect(subject.matches?({})).to be_false
    end

    it 'matches non-empty hashes' do
      expect(subject.matches?({stuff: 'things'})).to be_true
    end

    it 'matches other non-nil objects' do
       expect(subject.matches?(22)).to be_true
    end

  end

end

describe 'present predicate' do

  before :all do
    class User
      verifiable

      attr_accessor :data
      data_must be_present
    end
  end

  subject { User.new }

  context 'with empty data' do

    before do
      subject.data = []
    end

    it { should_not be_valid }

    it "has the correct error message" do
      subject.valid?
      expect(subject.validation_errors).to include(:data => ['must be present'])
    end
  end
 
   context 'with some data' do

    before do 
      subject.data = ['stuff']
    end 

    it { should be_valid }
  end

end
