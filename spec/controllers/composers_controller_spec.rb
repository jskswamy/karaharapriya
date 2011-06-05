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

  it "should assign composer" do
    get :new

    composer = assigns[:composer]
    composer.should_not be_nil
  end

  describe "create" do

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
      parameters = {:composer => {:name => "Thyagarajar", :century => "18th", :info => nil }}
      post :create, parameters

      response.should_not be_success
      response.response_code.should == 400
      errors = response.header["Errors"]
      errors.should_not be_blank
      errors.should == {:model_name => "composer", :errors => [{:field => :info, :errors => ["can't be blank"]}]}.to_json
    end

  end

  describe "edit" do

    it "should load the composer" do
      composer = Factory(:composer, :name => "Thyagarajar", :century => "19", :info => "A")

      get :edit, :id => composer.to_param
      actual_composer = assigns[:composer]
      actual_composer.should == composer
    end

  end

  describe "update" do

    it "should update the composer" do
      composer = Factory(:composer, :name => "Thyagarajar", :century => "19", :info => "A")
      parameters = {:id => composer.to_param, :composer => {:name => "Boominathar", :info => "B", :century => "19th" }}

      put :update, parameters
      response.should be_success
      response.body.should == {:redirect_url => "/composers"}.to_json
      composer = Composer.first
      composer.name.should == "Boominathar"
      composer.century.should == "19th"
      composer.info.should == "B"
    end

    it "should have validationErrors as response type in case of validation errors" do
      composer = Factory(:composer, :name => "Thyagarajar", :century => "19", :info => "A")
      parameters = {:id => composer.to_param, :composer => {:name => "Boominathar", :century => "19th", :info => nil }}
      post :update, parameters

      response.should_not be_success
      response.response_code.should == 400
      errors = response.header["Errors"]
      errors.should_not be_blank
      errors.should == {:model_name => "composer", :errors => [{:field => :info, :errors => ["can't be blank"]}]}.to_json
    end

  end

end
