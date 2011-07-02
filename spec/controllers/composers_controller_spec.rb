require 'spec_helper'

describe ComposersController do

  it "should load all the composers" do
    composers = []
    2.times { composers << Factory(:composer) }
    get :index

    actual_composers = assigns[:composers]
    actual_composers.should_not be_nil
    actual_composers.count.should == 2
    composers.each { |composer| actual_composers.include?(composer).should be_true }
  end

  describe "new" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should assign composer" do
      get :new

      composer = assigns[:composer]
      composer.should_not be_nil
    end

  end

  describe "create" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should create new composer" do
      parameters = {:composer => {:name => "Thyagarajar", :century => "18th", :info => "Great Composer" }}
      post :create, parameters

      response.should be_success
      response.body.should == {:redirect_url => "/composers"}.to_json
      composers = Composer.all.to_a
      composers.count.should == 1
      composer = composers.first
      composer.name.should == "Thyagarajar"
      composer.century.should == "18th"
      composer.info.should == "Great Composer"
    end

    it "should have validationErrors as response type in case of validation errors" do
      parameters = {:composer => {:century => "18th"}}
      post :create, parameters

      response.should_not be_success
      response.response_code.should == 400
      errors = response.header["X-Json"]
      errors.should_not be_blank
      errors.should == {:model_name => "composer", :errors => [{:field => :name, :errors => ["can't be blank"]}]}.to_json
    end

  end

  describe "edit" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should load the composer" do
      composer = Factory(:composer, :name => "Thyagarajar", :century => "19")

      get :edit, :id => composer.to_param
      actual_composer = assigns[:composer]
      actual_composer.should == composer
    end

  end

  describe "update" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should update the composer" do
      composer = Factory(:composer, :name => "Thyagarajar", :century => "19")
      parameters = {:id => composer.to_param, :composer => {:name => "Boominathar", :century => "19th" }}

      put :update, parameters
      response.should be_success
      response.body.should == {:redirect_url => "/composers"}.to_json
      composer = Composer.first
      composer.name.should == "Boominathar"
      composer.century.should == "19th"
    end

    it "should have validationErrors as response type in case of validation errors" do
      composer = Factory(:composer, :name => "Thyagarajar", :century => "19")
      parameters = {:id => composer.to_param, :composer => {:name => nil, :century => "19th"}}
      post :update, parameters

      response.should_not be_success
      response.response_code.should == 400
      errors = response.header["X-Json"]
      errors.should_not be_blank
      errors.should == {:model_name => "composer", :errors => [{:field => :name, :errors => ["can't be blank"]}]}.to_json
    end

  end

  describe "show" do

    it "should load composer" do
      composer = Factory(:composer)
      get :show, :id => composer.to_param

      response.should be_success
      expected_composer = assigns[:composer]
      expected_composer.should_not be_nil
      expected_composer.should == composer
    end

  end

end
