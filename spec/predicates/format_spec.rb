require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Object using a format predicate" do

  before(:each) do
    class User
      verifiable

      attr_accessor :pin
      pin_must match, /\A[0-9]{4}\Z/

    end
  end

  context "and an invalid instance" do
    before(:each) do
      @user = User.new
      @user.pin = "0A18"
    end
    subject { @user }

    it { should_not be_valid }
  end

  context "and a valid instance" do
    before(:each) do
      @user = User.new
      @user.pin = "0142"
    end
    subject { @user }

    it { should be_valid }
  end

end
