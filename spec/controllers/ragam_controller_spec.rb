require 'spec_helper'

describe RagamController do

  it "should create a ragam" do
    ragam_name = "Karaharapriya"
    post :create, :name => ragam_name, :arohana => "sa re2 ga1 ma1 pa th2 ni1 sa", :avarohana => "sa ni1 th2 pa ma1 ga1 re2 sa"
    response.should be_success
    Ragam.find_by_name(ragam_name).should_not be nil
  end

end
