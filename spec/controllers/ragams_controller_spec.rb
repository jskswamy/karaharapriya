require 'spec_helper'

describe RagamsController do

  it "index should load all the ragams" do
    ragams = []
    2.times { ragams << Factory(:ragam) }
    get :index
    expected_ragams = assigns[:ragams]
    expected_ragams.count.should == 2
    expected_ragams.should == ragams
  end

  describe "new" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "ragam should not be nil for create" do
      get :new

      assigns[:ragam].should_not be_nil
    end

  end

  describe "create" do

    before(:each) do
      sign_in Factory(:user)
      @parent_ragam = Factory(:ragam, :name => "Sankarabharanam")
    end

    it "should create ragam" do
      post :create, {:ragam=>{:name => "Mohanam",
                              :arohana => "sa ri ga pa th sa",
                              :avarohana => "sa th pa ga ri sa",
                              :description => "Mohana ragam",
                              :parent_id => @parent_ragam.id,
                              :parent => @parent_ragam.name }}

      response.should be_success
      response.body.should == {:redirect_url => "/ragams"}.to_json
      Ragam.all.count.should == 2
      ragam = Ragam.find_by_translated_field("name","Mohanam")
      ragam.should_not be_nil
      ragam.name.should == "Mohanam"
      ragam.arohana.should == "sa ri ga pa th sa"
      ragam.avarohana.should == "sa th pa ga ri sa"
      ragam.parent.should == @parent_ragam
    end

    it "should have validationErrors as response type in case of validation errors" do
      post :create, {:ragam=>{:arohana => "sa ri ga pa th sa",
                              :avarohana => "sa th pa ga ri sa",
                              :description => "Mohana ragam",
                              :parent_id => @parent_ragam.id,
                              :parent => @parent_ragam.name }}

      response.should_not be_success
      response.response_code.should == 400
      errors = response.headers["X-JSON"]
      errors.should_not be_blank
      errors.should == {:model_name => "ragam", :errors => [{:field => :name, :errors => ["can't be blank"]}]}.to_json
    end

  end

  describe "edit" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should load ragam for edit" do
      ragam = Factory(:ragam)
      get :edit, {:id => ragam.to_param}

      expected_ragam = assigns[:ragam]
      expected_ragam.should_not be_nil
      expected_ragam.should == ragam
    end

  end

  describe "update" do

    before(:each) do
      sign_in Factory(:user)
      parent_ragam = Factory(:ragam, :name => "Sankarabharanam")
      @another_parent_ragam = Factory(:ragam, :name => "Mayamalava gowlai")
      @ragam = Factory(:ragam, :name => "Mohanam", :parent => parent_ragam)
    end

    it "should create ragam" do
      put :update, {:id => @ragam.to_param, :ragam =>{:name => "Gowlai",
                                                :arohana => "sa ri ga ma pa th ni sa",
                                                :avarohana => "sa ni th pa ma ga ri sa",
                                                :description => "Gowlao ragam",
                                                :parent_id => @another_parent_ragam.id,
                                                :parent => @another_parent_ragam.name }}

      response.should be_success
      response.body.should == {:redirect_url => "/ragams"}.to_json
      Ragam.all.count.should == 3
      ragam = Ragam.first(:conditions => {:id => @ragam.id})
      ragam.should_not be_nil
      ragam.arohana.should == "sa ri ga ma pa th ni sa"
      ragam.avarohana.should == "sa ni th pa ma ga ri sa"
      ragam.name.should == "Gowlai"
      ragam.parent.should == @another_parent_ragam
    end

    it "should have validationErrors as response type in case of validation errors" do
      put :update, {:id => @ragam.to_param, :ragam =>{:name => nil,
                                                :arohana => "sa ri ga ma pa th ni sa",
                                                :avarohana => "sa ni th pa ma ga ri sa",
                                                :description => "Gowlao ragam",
                                                :parent_id => @another_parent_ragam.id,
                                                :parent => @another_parent_ragam.name }}

      response.should_not be_success
      response.response_code.should == 400
      errors = response.headers["X-JSON"]
      errors.should_not be_blank
      errors.should == {:model_name => "ragam", :errors => [{:field => :name, :errors => ["can't be blank"]}]}.to_json
      Ragam.all.count.should == 3
      ragam = Ragam.find_by_translated_field("name",@ragam.name)
      ragam.should_not be_nil
      ragam.name.should_not == "Gowlai"
      ragam.arohana.should_not == "sa ri ga ma pa th ni sa"
      ragam.avarohana.should_not == "sa ni th pa ma ga ri sa"
      ragam.parent.should_not == @another_parent_ragam
    end

  end

  describe "show" do

    it "should assign the ragam" do
      ragam = Factory(:ragam)
      get :show, :id => ragam.to_param
      response.should be_true
      expected_ragam = assigns(:ragam)
      expected_ragam.should_not be_nil
      expected_ragam.should == ragam
    end

  end

end
