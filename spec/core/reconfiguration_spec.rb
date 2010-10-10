require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Objects with reconfigured predicates" do
  context "with a single parameter" do
    before(:each) do
      class User
        verifiable

        attr_accessor :login
        login_must have_length, :at_least => 5
      end
    end
    context "and an invalid instance" do
      before(:each) do
        @user = User.new
        @user.login = "user"
      end
      subject { @user }

      it { should_not be_valid }
    end

    context "and a valid instance" do
      before(:each) do
        @user = User.new
        @user.login = "username"
      end
      subject { @user }

      it { should be_valid }
    end
  end

  context "with multiple parameters" do
    before(:each) do
      class User
        verifiable

        attr_accessor :login
        login_must have_length, :at_least => 5, :at_most => 9
      end
    end
    context "and an invalid instance with a short attribute" do
      before(:each) do
        @user = User.new
        @user.login = "user"
      end
      subject { @user }

      it { should_not be_valid }
    end

    context "and an invalid instance with a long attribute" do
      before(:each) do
        @user = User.new
        @user.login = "overlylong"
      end
      subject { @user }

      it { should_not be_valid }
    end

    context "and a valid instance" do
      before(:each) do
        @user = User.new
        @user.login = "username"
      end
      subject { @user }

      it { should be_valid }
    end
  end
end
