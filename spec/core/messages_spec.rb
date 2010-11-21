require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Object using a negative nil predicate" do

  before(:all) do
    class User
      verifiable

      attr_accessor :login
      login_must_not be_nil

    end
  end

  context "when instantiated with" do
    context "an invalid record" do
      before(:each) do
        @user = User.new
        @user.valid?
      end

      context "the validation errors" do
        subject { @user.validation_errors }

        it { should be_a(Hash) }

        it { should have_key(:login) }

        context "with each attribute" do
          subject { @user.validation_errors[:login] }

          it { should be_a(Array) }

          it { should have(1).items }

        end

      end

      context "when made valid" do
        before(:each) do
          @user.login = "something"
          @user.valid?
        end

        context "the validation errors" do
          subject { @user.validation_errors }

          it { should be_empty }
        end

      end

    end

    context "with a valid record the message hash" do
      before(:each) do
        @user = User.new
        @user.login = "something"
        @user.valid?
      end
      subject { @user.validation_errors }

      it { should be_empty }

    end

  end

end
