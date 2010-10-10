require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Object using blank predicate" do

  before(:all) do
    class User
      verifiable

      attr_accessor :login
      login_must_not be_blank

    end
  end

  context "when instantiated with" do

    context "nothing" do
      before(:each) do
        @user = User.new
      end
      subject { @user }
      
      it { should_not be_valid }
    end

    context "an empty string" do
      before(:each) do
        @user = User.new
        @user.login = ""
      end
      subject { @user }

      it { should_not be_valid }
    end

    context "a string" do
      before(:each) do
        @user = User.new
        @user.login = "something"
      end
      subject { @user }

      it { should be_valid }
    end

    context "a string containing nothing but spaces" do
      before(:each) do
        @user = User.new
        @user.login = "   "
      end
      subject { @user }

      it { should_not be_valid }
    end

    context "a string with leading and trailing spaces" do
      before(:each) do
        @user = User.new
        @user.login = " something "
      end
      subject { @user }

      it { should be_valid }
    end

  end

end
