require 'spec_helper'

describe Song do

  describe "validations" do

    it "should not be able to create a song without name" do
      song = Factory.build(:song, :name => nil)
      song.valid?.should be_false
      song.errors.full_messages.to_sentence.should == "Name can't be blank"
    end

    it "should not be able to create a song without ragam" do
      song = Factory.build(:song, :ragam => nil)
      song.valid?.should be_false
      song.errors.full_messages.to_sentence.should == "Ragam can't be blank"
    end

    it "should not be able to create a song without talam" do
      song = Factory.build(:song, :talam => nil)
      song.valid?.should be_false
      song.errors.full_messages.to_sentence.should == "Talam can't be blank"
    end

    it "should not be able to create a song without song type" do
      song = Factory.build(:song, :song_type => nil)
      song.valid?.should be_false
      song.errors.full_messages.to_sentence.should == "Song type can't be blank"
    end

    it "should not be able to create a song without content" do
      song = Factory.build(:song, :content => nil)
      song.valid?.should be_false
      song.errors.full_messages.to_sentence.should == "Content can't be blank"
    end

    it "should not have duplicate name" do
      ragam = Factory(:ragam)
      talam = Factory(:talam)
      composer = Factory(:composer)
      song = Factory(:song, :name => "name")
      duplicate_song = Factory.build(:song, :name => "name")
      duplicate_song.save
      duplicate_song.errors.full_messages.to_sentence.should == "Name is already taken"
    end

  end

  it "to_param should return name" do
    song = Factory(:song, :name => "Gananatha")
    song.to_param.should == "Gananatha"
  end

  it "should find by id" do
    song = Factory(:song)
    Song.find_by_id(song.id).should == song
  end

end
