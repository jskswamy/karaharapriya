require 'spec_helper'

describe SongComposition do

  it "should delegate name to song_content_type" do
    song_composition = Factory(:song_composition)
    song_composition.name.should == song_composition.song_content_type.name
  end

  it "should not create song composition without song type" do
    some_composition = Factory.build(:song_composition, :song_type => nil)
    some_composition.valid?.should be_false
    some_composition.errors.full_messages.to_sentence.should == "Song type can't be blank"
  end

  it "should not create song composition without song content type" do
    some_composition = Factory.build(:song_composition, :song_content_type => nil)
    some_composition.valid?.should be_false
    some_composition.errors.full_messages.to_sentence.should == "Song content type can't be blank"
  end

  it "should not create duplicate composition" do
    song_type = Factory(:song_type)
    song_content_type = Factory(:song_content_type)
    some_composition = Factory(:song_composition, :song_type => song_type, :song_content_type => song_content_type)
    some_composition_same = Factory.build(:song_composition, :song_type => song_type, :song_content_type => song_content_type)

    some_composition_same.valid?.should be_false
  end

end
