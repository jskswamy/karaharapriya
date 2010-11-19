require 'spec_helper'

describe TalamController do

  before(:each) do
    @adhi = Factory(:talam, :name => "Adi", :avartanam => "1 0 0", :laghu_length => 4)
    @rupagam = Factory(:talam, :name => "Rupkum", :avartanam => "0 1", :laghu_length => 4)
    @another_adhi = Factory(:talam, :name => "Another Adhi", :avartanam => "0 1 1", :laghu_length => 4)
  end

  describe "suggest" do

    it "should show all the talams" do
      get :suggest
      response.should be_success
      assigns[:talams].should == [@adhi, @rupagam, @another_adhi]
    end

    it "should show only the matching talam" do
      get :suggest, :name => "a"
      response.should be_success
      assigns[:talams].should == [@adhi, @another_adhi]
    end

  end

end
