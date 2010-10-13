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

end
