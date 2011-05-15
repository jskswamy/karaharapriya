require 'spec_helper'

describe SongsController do

  it "should list the songs from the system" do
    song1 = Factory(:song, :name => "my_name_1")
    song2 = Factory(:song, :name => "my_name_2")

    get :index
    assigns(:songs).should == [song1,song2]
    response.should be_success
  end

  it "should assign song type" do
    song_types = []
    2.times { song_types << Factory(:song_type) }
    get :new
    response.should be_success
    response.should render_template(:new)
    assigns[:song_types].should_not be_nil
    assigns[:song_types].should == song_types
  end

  it "should render the editor" do
    get :editor, :index => 1
    response.should be_success
    response.should render_template(:editor)
  end

  it "should create song and its contents" do
    ragam = Factory(:ragam)
    talam = Factory(:talam)
    geetham = Factory(:song_type, :name => "geetham")
    composer = Factory(:composer)
    post :create, { :name => "song",
                    :song_type => geetham.id.to_s,
                    :talam_id => talam.id.to_s,
                    :ragam_id => ragam.id.to_s,
                    :composer_id => composer.id.to_s,
                    :description => "song description",
                    :content => "sa re ga ma" }

    response.should be_success
    response.body.should == {:model_name => "song", :errors => [], :redirect_url => "/songs"}.to_json
    Song.all.count.should == 1
    song = Song.first
    song.name.should == "song"
    song.song_type.should == geetham
    song.composer.should == composer
    song.ragam.should == ragam
    song.talam.should == talam
    song.description.should == "song description"
    song.content.should == "sa re ga ma"
  end

  it "should have validationErrors as response type in case of validation errors" do
    ragam = Factory(:ragam)
    talam = Factory(:talam)
    composer = Factory(:composer)
    thyagaraja = Factory(:composer)
    sarali = Factory(:song_type, :name => "sarali")
    post :create, { :song_type => sarali.id.to_s,
                    :talam_id => talam.id.to_s,
                    :ragam_id => ragam.id.to_s,
                    :composer_id => composer.id.to_s,
                    :description => "song description",
                    :content => "sa re ga ma" }

    response.should be_success
    response.body.should == {:model_name => "song", :errors => [{:field => :name, :errors => ["can't be blank"]}], :redirect_url => "/songs"}.to_json
  end

end
