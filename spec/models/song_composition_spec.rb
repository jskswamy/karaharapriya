require 'spec_helper'

describe SongComposition do
  it "should delegate name to song_content_type" do
    song_composition = Factory(:song_composition)
    song_composition.name.should == song_composition.song_content_type.name
  end
end
