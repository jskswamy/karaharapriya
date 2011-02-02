require 'spec_helper'

describe SongsController do

  it "should list the songs from the system" do
    song1 = Factory(:song, :name => "my_name_1")
    song2 = Factory(:song, :name => "my_name_2")

    get :index
    assigns(:songs).should == [song1,song2]
  end

  it "should get the response which has the editors based on song composition" do
    song_type = Factory(:song_type, :name => "swarajathi")
    pallavi = Factory(:song_content_type, :name => "Pallavi")
    anu_pallavi = Factory(:song_content_type, :name => "Anu Pallavi")
    swarajathi_pallavi = Factory(:song_composition, :song_type => song_type, :song_content_type => pallavi)
    swarajathi_anu_pallavi = Factory(:song_composition, :song_type => song_type, :song_content_type => anu_pallavi)

    get :editor, {"song_type_id" => song_type.id}
    assigns(:song_compositions).should == [swarajathi_pallavi, swarajathi_anu_pallavi]
    response.should render_template("songs/_editor")
  end

  it "should get the create song instruction when an invalid song type is specified" do
    get :editor, {"song_type_id" => -1}
    response.should render_template("songs/_create_instruction")
  end

  it "should load the song types on new song in alphabetical order" do
    sarali = Factory(:song_type, :name => "sarali")
    janda = Factory(:song_type, :name => "janda")

    get :new
    assigns(:song_types).should == [janda, sarali]
  end

  it "should create song and its contents" do
    thyagaraja = Factory(:composer)
    sarali = Factory(:song_type, :name => "sarali")
    pallavi = Factory(:song_content_type, :name => "Pallavi")
    anupallavi = Factory(:song_content_type, :name => "Anupallavi")

    post :create, {"song_contents" => {
                                      "0" => {
                                              "body" => "sa re ga ma<br>",
                                               "song_content_type_id" => pallavi.id
                                             },
                                      "1" => {
                                              "body" => "sa re ga ma<br>",
                                              "song_content_type_id" => anupallavi.id
                                             }
                                      },
                   "song" => { "name" => "new song", "song_type_id" => sarali.id, "composer_id" => thyagaraja.id, }}

    Song.find_by_name("new song").should_not be_nil
    response.should be_success
    response.body.should == {:model_name => "song", :errors => [], :has_errors => false, :redirect_url => "/songs"}.to_json
  end

  it "should have validationErrors as response type in case of validation errors" do
    thyagaraja = Factory(:composer)
    sarali = Factory(:song_type, :name => "sarali")
    post :create, {"song" => {"song_type_id" => sarali.id, "composer_id" => thyagaraja.id}}
    response.should be_success
    response.body.should == {:model_name => "song", :errors => [{:field => :name, :errors => ["can't be blank"]}], :has_errors => true, :redirect_url => "/songs"}.to_json
  end

end
