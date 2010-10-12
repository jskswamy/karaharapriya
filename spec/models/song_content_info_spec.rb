require 'spec_helper'

describe SongContentInfo do

  it "should be associated polymorphically to ragam" do
    ragam = Factory(:ragam)
    song_content_info = Factory(:song_content_info, :info => ragam)
    song_content_info.info.should == ragam
  end

  it "should be associated polymorphically to talam" do
    talam = Factory(:talam)
    song_content_info = Factory(:song_content_info, :info => talam)
    song_content_info.info.should == talam
  end

end
