require 'spec_helper'

describe SongsController do

  it "should list the songs from the system" do
    song1 = Factory(:song, :name => "my_name_1")
    song2 = Factory(:song, :name => "my_name_2")

    get :index
    assigns(:songs).should == [song1,song2]
    response.should be_success
  end

  describe "new" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should assign song type and song for new" do
      song_types = []
      2.times { song_types << Factory(:song_type) }
      get :new
      response.should be_success
      response.should render_template(:new)
      assigns[:song_types].should_not be_nil
      assigns[:song].should_not be_nil
      assigns[:song_types].should == song_types
    end

  end

  describe "create" do

    before(:each) do
      sign_in Factory(:user)
      @ragam = Factory(:ragam)
      @talam = Factory(:talam)
      @song_type = Factory(:song_type, :name => "geetham")
      @composer = Factory(:composer)
    end

    it "should create song and its contents" do
      post :create, {:song =>{:name => "song",
                              :song_type => @song_type.id.to_s,
                              :description => "song description",
                              :content => "sa re ga ma",
                              :talam_id => @talam.id.to_s,
                              :ragam_id => @ragam.id.to_s,
                              :composer_id => @composer.id.to_s,
                              :composer => @composer,
                              :talam => @talam,
                              :ragam => @ragam }}

      response.should be_success
      response.body.should == {:redirect_url => "/songs"}.to_json
      Song.all.count.should == 1
      song = Song.first
      song.name.should == "song"
      song.song_type.should == @song_type
      song.composer.should == @composer
      song.ragam.should == @ragam
      song.talam.should == @talam
      song.description.should == "song description"
      song.content.should == "sa re ga ma"
    end

    it "should have validationErrors as response type in case of validation errors" do
      post :create, {:song =>{:song_type => @song_type.id.to_s,
                              :description => "song description",
                              :content => "sa re ga ma",
                              :talam_id => @talam.id.to_s,
                              :ragam_id => @ragam.id.to_s,
                              :composer_id => @composer.id.to_s,
                              :composer => @composer,
                              :talam => @talam,
                              :ragam => @ragam }}

      response.should_not be_success
      response.response_code.should == 400
      errors = response.headers["Errors"]
      errors.should_not be_blank
      errors.should == {:model_name => "song", :errors => [{:field => :name, :errors => ["can't be blank"]}]}.to_json
    end

  end

  describe "edit" do

    before(:each) do
      sign_in Factory(:user)
    end

    it "should assign song type and song for edit" do
      song_types = []
      2.times { song_types << Factory(:song_type) }
      song = Factory(:song, :song_type => song_types.first)
      get :edit, :id => song.name

      response.should be_success
      response.should render_template(:edit)
      assigns[:song_types].should_not be_nil
      assigns[:song].should == song
      song_types = assigns[:song_types]
      song_types.count.should == 2
      song_types.should == song_types
    end

  end

  describe "update" do

    before(:each) do
      sign_in Factory(:user)
      @ragam = Factory(:ragam)
      @talam = Factory(:talam)
      @song_type = Factory(:song_type, :name => "geetham")
      @composer = Factory(:composer)
    end

    it "should update song and its contents" do
      song = Factory(:song)
      put :update, {:id => song.name,
                     :song =>{:name => "song",
                              :song_type => @song_type.id.to_s,
                              :description => "song description",
                              :content => "sa re ga ma",
                              :talam_id => @talam.id.to_s,
                              :ragam_id => @ragam.id.to_s,
                              :composer_id => @composer.id.to_s,
                              :composer => @composer,
                              :talam => @talam,
                              :ragam => @ragam }}

      response.should be_success
      response.body.should == {:redirect_url => "/songs"}.to_json
      Song.all.count.should == 1
      song = Song.first(:conditions => {:id => song.id})
      song.name.should == "song"
      song.song_type.should == @song_type
      song.composer.should == @composer
      song.ragam.should == @ragam
      song.talam.should == @talam
      song.description.should == "song description"
      song.content.should == "sa re ga ma"
    end

    it "should have validationErrors as response type in case of validation errors" do
      song = Factory(:song)
      put :update, {:id => song.name,
                     :song =>{:name => nil,
                              :song_type => @song_type.id.to_s,
                              :description => "song description",
                              :content => "sa re ga ma",
                              :talam_id => @talam.id.to_s,
                              :ragam_id => @ragam.id.to_s,
                              :composer_id => @composer.id.to_s,
                              :composer => @composer,
                              :talam => @talam,
                              :ragam => @ragam }}

      response.should_not be_success
      response.response_code.should == 400
      errors = response.headers["Errors"]
      errors.should_not be_blank
      errors.should == {:model_name => "song", :errors => [{:field => :name, :errors => ["can't be blank"]}]}.to_json
      song = Song.first(:conditions => {:id => song.id})
      song.name.should_not == "song"
      song.song_type.should_not == @song_type
      song.composer.should_not == @composer
      song.ragam.should_not == @ragam
      song.talam.should_not == @talam
      song.description.should_not == "song description"
      song.content.should_not == "sa re ga ma"
    end

  end

end
