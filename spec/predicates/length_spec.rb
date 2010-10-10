require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Object using length predicate" do

  context "with an at least condition" do

    before(:each) do
      class User
        verifiable

        attr_accessor :login
        login_must have_length(:at_least => 5)

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

  context "with a less than condition" do

    before(:each) do
      class User
        verifiable

        attr_accessor :login
        login_must_not have_length(:less_than => 5)

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

  context "with a greater than condition" do

    before(:each) do
      class User
        verifiable

        attr_accessor :login
        login_must have_length(:greater_than => 4)

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

  context "with an at most condition" do

    before(:each) do
      class User
        verifiable

        attr_accessor :login
        login_must_not have_length(:at_most => 5)

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

  context "with an exactly condition" do

    before(:each) do
      class User
        verifiable

        attr_accessor :pin
        pin_must have_length(:exactly => 4)

      end
    end

    context "and an invalid instance with a short field" do
      before(:each) do
        @user = User.new
        @user.pin = "123"
      end
      subject { @user }

      it { should_not be_valid }
    end

    context "and an invalid instance with a long field" do
      before(:each) do
        @user = User.new
        @user.pin = "12345"
      end
      subject { @user }

      it { should_not be_valid }
    end

    context "and a valid instance" do
      before(:each) do
        @user = User.new
        @user.pin = "1234"
      end
      subject { @user }

      it { should be_valid }
    end

  end

end
