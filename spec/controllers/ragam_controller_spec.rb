require 'spec_helper'

describe RagamController do

  it "should create a ragam" do
    ragam_name = "Karaharapriya"
    post :create, :name => ragam_name
    Ragam.find_by_name(ragam_name).should_not be nil
  end

end
