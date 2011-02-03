require 'spec_helper'

describe RemoteResponse do

  it "should determine whether it has error or not" do
    model = Factory.build(:ragam, :name => nil)
    model.save
    redirect_url = "some_url"
    remote = RemoteResponse.new(model, redirect_url);
    remote.errors.should == [{:field => :name, :errors => model.errors[:name]}]
    remote.redirect_url.should == redirect_url
  end

end
