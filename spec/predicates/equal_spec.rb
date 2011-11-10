require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Object using equal predicate" do

  before(:all) do 
    class User 
      verifiable 

      attr_accessor :password, :password_confirmation
      password_confirmation_must be_equal, :to => the(:password)
    end
  end

  context "when instantiated with" do 

    context "matching items" do 
      before(:each) do 
        @user = User.new 
        @user.password = "foo"
        @user.password_confirmation = "foo"
      end
      subject { @user }

      it { should be_valid }
    end

    context "unequal items" do 
      before(:each) do 
        @user = User.new 
        @user.password = "foo"
        @user.password_confirmation = "bar"
      end
      subject { @user }

      it { should_not be_valid }
    end

  end

end
