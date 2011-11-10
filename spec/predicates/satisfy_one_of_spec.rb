require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Object using or predicate" do

  before(:all) do 
    class User 
      verifiable

      attr_accessor :password, :password_conf_1, :password_conf_2
      password_must satisfy_one_of, be_equal(:to => the(:password_conf_1)), be_equal(:to => the(:password_conf_2))
    end
  end

  context "when instantiated with" do 

    context "something matching the first predicate" do 
      before(:each) do 
        @user = User.new 
        @user.password = "foo"
        @user.password_conf_1 = "foo"
        @user.password_conf_2 = "bar"
      end
      subject { @user }

      it { should be_valid }
    end

    context "something matching the second predicate" do 
      before(:each) do 
        @user = User.new 
        @user.password = "foo"
        @user.password_conf_1 = "bar"
        @user.password_conf_2 = "foo"
      end
      subject { @user }

      it { should be_valid }
    end

    context "something matching the both predicates" do 
      before(:each) do 
        @user = User.new 
        @user.password = "foo"
        @user.password_conf_1 = "foo"
        @user.password_conf_2 = "foo"
      end
      subject { @user }

      it { should be_valid }
    end

    context "something matching the neither predicates" do 
      before(:each) do 
        @user = User.new 
        @user.password = "foo"
        @user.password_conf_1 = "bar"
        @user.password_conf_2 = "bar"
      end
      subject { @user }

      it { should_not be_valid }
    end
  end
end
