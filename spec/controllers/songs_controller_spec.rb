require 'spec_helper'

describe SongsController do

  it "should get the response which has the editors based on song composition" do
    song_type = Factory(:song_type, :name => "swarajathi")
    pallavi = Factory(:song_content_type, :name => "Pallavi")
    anu_pallavi = Factory(:song_content_type, :name => "Anu Pallavi")
    swarajathi_pallavi = Factory(:song_composition, :song_type => song_type, :song_content_type => pallavi)
    swarajathi_anu_pallavi = Factory(:song_composition, :song_type => song_type, :song_content_type => anu_pallavi)

    get :editor, {:song_type => "swarajathi"}
    assigns(:song_compositions).should == [swarajathi_pallavi, swarajathi_anu_pallavi]
  end

  it "should load the song types on new song in alphabetical order" do
    sarali = Factory(:song_type, :name => "sarali")
    janda = Factory(:song_type, :name => "janda")

    get :new
    assigns(:song_types).should == [janda.name, sarali.name]
  end


  it "should load the composers on new song in alphabetical order" do
    thyagraja = Factory(:composer)
    oothkadu_venkarasubbair = Factory(:composer, :name => "Oothukadu Venkara subbier", :century => "18th")

    get :new
    assigns(:composers).should == [oothkadu_venkarasubbair.name, thyagraja.name]
  end

end
