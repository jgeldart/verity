require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "An object with lazy attributes" do

  context "using an unparameterised block" do
    before(:all) do
      class Message
        verifiable
        attr_accessor :body
        body_must have_length, :exactly => lambda{ 17 }
      end
    end

    context "when instantiated with matching data" do
      before(:each) do
        @msg = Message.new
        @msg.body = "Lorem ipsum dolor"
      end
      subject { @msg }

      it { should be_valid }
    end

    context "when instantiated with non-matching data" do
      before(:each) do
        @msg = Message.new
        @msg.body = "Lorem ipsum dolor sit amet"
      end
      subject { @msg }

      it { should_not be_valid }
    end
  end

  context "using a parameterised block" do
    before(:all) do
      class Echolalia
        verifiable
        attr_accessor :prompt_length, :response
        response_must have_length, :exactly => lambda{|r| r.prompt_length }
      end
    end

    context "when instantiated with matching data" do
      before(:each) do
        @echo = Echolalia.new
        @echo.prompt_length = 17
        @echo.response = "Lorem ipsum dolor"
      end
      subject { @echo }

      it { should be_valid }
    end

    context "when instantiated with non-matching data" do
      before(:each) do
        @echo = Echolalia.new
        @echo.prompt_length = 17
        @echo.response = "Lorem ipsum dolor sit amet"
      end
      subject { @echo }

      it { should_not be_valid }
    end
  end

  context "using an attribute shorthand" do
    before(:all) do
      class Echo
        verifiable
        attr_accessor :prompt_length, :response
        response_must have_length, :exactly => the(:prompt_length)
      end
    end

    context "when instantiated with matching data" do
      before(:each) do
        @echo = Echo.new
        @echo.prompt_length = 17
        @echo.response = "Lorem ipsum dolor"
      end
      subject { @echo }

      it { should be_valid }
    end

    context "when instantiated with non-matching data" do
      before(:each) do
        @echo = Echo.new
        @echo.prompt_length = 17
        @echo.response = "Lorem ipsum dolor sit amet"
      end
      subject { @echo }

      it { should_not be_valid }
    end
  end

end
