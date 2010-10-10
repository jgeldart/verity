require File.dirname(__FILE__) + "/../spec_helper.rb"

class User
  attr_accessor :login
end

describe Object do
  context "with multiple validations" do
    before(:each) do
      class User
        verifiable
        login_must_not be_nil
        login_must_not have_length(:less_than => 5)
      end
    end
    subject { User }

    context "an invalid instance which fails the first validation" do
      before(:each) do
        @user_without_login = User.new
      end
      subject { @user_without_login }

      it { should_not be_valid }
    end
    context "an invalid instance which fails the second validation" do
      before(:each) do
        @user_with_short_login = User.new
        @user_with_short_login.login = "user"
      end
      subject { @user_with_short_login }

      it { should_not be_valid }
    end

    context "a valid instance" do
      before(:each) do
        @user = User.new
        @user.login = "valid"
      end
      subject { @user }

      it { should be_valid }
    end
  end
end
