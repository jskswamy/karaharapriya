require 'spec_helper'

describe SongContent do

  it "should not create song content without song" do
    content = Factory.build(:song_content, :song => nil)

    content.valid?.should be_false
    content.errors.full_messages.to_sentence.should == "Song can't be blank"
  end

  it "should not create song content without body" do
    content = Factory.build(:song_content, :body => nil)

    content.valid?.should be_false
    content.errors.full_messages.to_sentence.should == "Body can't be blank"
  end

  it "should not create song content without song content type" do
    content = Factory.build(:song_content, :song_content_type => nil)

    content.valid?.should be_false
    content.errors.full_messages.to_sentence.should == "Song content type can't be blank"
  end

  it "should destroy the song contents when the song is destroyed" do
    content = Factory(:song_content)
    song = content.song
    song.destroy
    SongContent.all.count.should == 0
  end

end
