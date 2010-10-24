require 'spec_helper'

describe SongsController do

  it "should get the response which has the editors based on song composition" do
    song_type = Factory(:song_type, :name => "swarajathi")
    pallavi = Factory(:song_content_type, :name => "Pallavi")
    anu_pallavi = Factory(:song_content_type, :name => "Anu Pallavi")
    swarajathi_pallavi = Factory(:song_composition, :song_type => song_type, :song_content_type => pallavi)
    swarajathi_anu_pallavi = Factory(:song_composition, :song_type => song_type, :song_content_type => anu_pallavi)

    get :editor, {"song_type_id" => song_type.id}
    assigns(:song_compositions).should == [swarajathi_pallavi, swarajathi_anu_pallavi]
  end

  it "should load the song types on new song in alphabetical order" do
    sarali = Factory(:song_type, :name => "sarali")
    janda = Factory(:song_type, :name => "janda")

    get :new
    assigns(:song_types).should == [sarali, janda]
  end


  it "should load the composers on new song in alphabetical order" do
    thyagraja = Factory(:composer)
    oothkadu_venkarasubbair = Factory(:composer, :name => "Oothukadu Venkara subbier", :century => "18th")

    get :new
    assigns(:composers).should == [thyagraja, oothkadu_venkarasubbair]
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
  end

  it "should have validationErrors as response type in case of validation errors" do
    thyagaraja = Factory(:composer)
    sarali = Factory(:song_type, :name => "sarali")
    post :create, {"song" => {"song_type_id" => sarali.id, "composer_id" => thyagaraja.id}}
    response.headers["ResponseType"].should == "validationErrors"
  end 

end
