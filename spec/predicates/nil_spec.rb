require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Object using nil predicate" do

  before(:all) do
    class User
      verifiable

      attr_accessor :login
      login_must_not be_nil

      attr_accessor :citation
      citation_must be_nil
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

    context "a login" do
      before(:each) do
        @user = User.new
        @user.login = "something"
      end
      subject { @user }

      it { should be_valid } 
    end

    context "a citation" do
      before(:each) do
        @user = User.new
        @user.citation = "something else"
      end
      subject { @user }

      it { should_not be_valid }
    end

    context "a login and a citation" do
      before(:each) do
        @user = User.new
        @user.login = "something"
        @user.citation = "something else"
      end
      subject { @user }

      it { should_not be_valid }
    end

  end
end
