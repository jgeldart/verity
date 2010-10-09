require File.dirname(__FILE__) + "/spec_helper.rb"

class User 
  attr_accessor :login, :password, :password_confirmation, :email
end

describe Object do

  subject { Object }

  it { should respond_to(:verifiable) }

  context "before DSL has been added" do
    subject { User }

    it { should_not respond_to(:valid?) }
  end

  context "after DSL has been added" do
    before(:each) do
      User.verifiable
    end
    subject { User }
    
    it { should respond_to(:validations) }

    context "validations" do
      subject { User.validations }

      it { should be_a(Hash) }

      it { should eql({}) }
    end

    context "instances" do
      before(:each) do
        @user = User.new
      end
      subject { @user }

      it { should respond_to(:valid?) }

      context "without validations" do
        subject { @user }

        it { should be_valid }
      end
    end


  end

end
