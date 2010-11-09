require 'spec_helper'

describe RagamController do

  it "should create a ragam" do
    ragam_name = "Karaharapriya"
    post :create, :name => ragam_name, :arohana => "sa re2 ga1 ma1 pa th2 ni1 sa", :avarohana => "sa ni1 th2 pa ma1 ga1 re2 sa"
    Ragam.find_by_name(ragam_name).should_not be nil
  end

  describe "should suggest ragam" do

    before(:each) do
      @mayamalavagowlai = Factory(:ragam, :name => "Mayamalavagowlai", :arohana => "sa re1 ga2 ma1 pa th1 ni2 sa", :avarohana => "sa ni2 th1 pa ma1 ga2 re1 sa")
      @sankarabharanam = Factory(:ragam, :name => "Sankarabharanam", :arohana => "sa re2 ga2 ma1 pa th2 ni2 sa", :avarohana => "sa ni2 th2 pa ma1 ga2 re2 sa")
      @karharapriya = Factory(:ragam, :name => "Karharapriya", :arohana => "sa re2 ga1 ma1 pa th2 ni1 sa", :avarohana => "sa ni1 th2 pa ma1 ga1 re2 sa")
    end

    pending "show the available ragam" do
      get :suggest
      assigns[:ragams].should == [@mayamalavagowlai, @sankarabharanam, @karharapriya]
    end

  end

end
