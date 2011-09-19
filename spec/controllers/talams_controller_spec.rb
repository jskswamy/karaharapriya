require 'spec_helper'

describe TalamsController do

  it "should load all the talams" do
    talams = []
    2.times { talams << Factory(:talam) }
    get :index

    actual_talams = assigns[:talams]
    actual_talams.should_not be_nil
    actual_talams.count.should == 2
    talams.each { |talam| actual_talams.include?(talam).should be_true }
  end

  describe "new" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should assign talam" do
      get :new

      talam = assigns[:talam]
      talam.should_not be_nil
    end

  end

  describe "create" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should create new talam" do
      parameters = {:talam => {:name => "Adi", :avartanam => "1 U 0", :laghu_length => "4"}}
      post :create, parameters

      response.should be_success
      response.body.should == {:redirect_url => "/talams"}.to_json
      talams = Talam.all.to_a
      talams.count.should == 1
      talam = talams.first
      talam.name.should == "Adi"
      talam.avartanam.should == "1 U 0"
      talam.laghu_length.should == 4
    end

    it "should have validationErrors as response type in case of validation errors" do
      parameters = {:talam => {:name => "Adi", :avartanam => "1 U N 0", :laghu_length => "4"}}
      post :create, parameters

      response.should_not be_success
      response.response_code.should == 400
      errors = response.header["X-JSON"]
      errors.should_not be_blank
      errors.should == {:model_name => "talam", :errors => [{:field => :avartanam, :errors => ["has invalid character"]}]}.to_json
    end

  end

  describe "edit" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should load the talam" do
      talam = Factory(:talam, :name => "Adi", :avartanam => "1 U 0", :laghu_length => "4")

      get :edit, :id => talam.to_param
      actual_talam = assigns[:talam]
      actual_talam.should == talam
    end

  end

  describe "update" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should update the talam" do
      talam = Factory(:talam, :name => "Adi", :avartanam => "1 U 0", :laghu_length => "4")
      parameters = {:id => talam.to_param, :talam => {:name => "Roopagam", :avartanam => "1 0", :laghu_length => "3" }}

      put :update, parameters
      response.should be_success
      response.body.should == {:redirect_url => "/talams"}.to_json
      talam.reload
      talam.name.should == "Roopagam"
      talam.avartanam.should == "1 0"
      talam.laghu_length.should == 3
    end

    it "should have validationErrors as response type in case of validation errors" do
      talam = Factory(:talam, :name => "Adi", :avartanam => "1 U 0", :laghu_length => "4")
      parameters = {:id => talam.to_param, :talam => {:name => "Roopagam", :avartanam => "1 0 N", :laghu_length => "3" }}
      post :update, parameters

      response.should_not be_success
      response.response_code.should == 400
      errors = response.header["X-JSON"]
      errors.should_not be_blank
      errors.should == {:model_name => "talam", :errors => [{:field => :avartanam, :errors => ["has invalid character"]}]}.to_json
    end

  end

  describe "show" do

    it "should load the talam" do
      talam = Factory(:talam)
      get :show, :id => talam.to_param
      response.should be_success
      expected_talam = assigns[:talam]
      expected_talam.should_not be_nil
      expected_talam.should == talam
    end

  end

end
