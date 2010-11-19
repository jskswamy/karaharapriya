require 'spec_helper'

describe ComposerController do

  before(:each) do
    @first_composer = Factory(:composer, :name => "first")
    @second_composer = Factory(:composer, :name => "second")
    @third_composer = Factory(:composer, :name => "first first")
  end

  describe "suggest" do

    it "should show all the composers" do
      get :suggest
      response.should be_success
      assigns[:composers].should == [@first_composer, @second_composer, @third_composer]
    end

    it "should show only the matching composers" do
      get :suggest, :name => "fir"
      response.should be_success
      assigns[:composers].should == [@first_composer, @third_composer]
    end

  end

end
