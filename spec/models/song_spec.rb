require 'spec_helper'

describe Song do

  it 'should not create duplicate song for same type' do
    geetham = Factory(:song_type, :name => "Geetham")
    a_song = Factory(:song, :name => "Gananatha", :song_type => geetham)
    another_song = Factory.build(:song, :name => "Gananatha", :song_type => geetham)
    another_song.valid?.should be_false
    another_song.errors.full_messages.to_sentence.should == "Name has already been taken"
  end

  it 'should be able to create a song with same name in different type' do
    geetham = Factory(:song_type, :name => "Geetham")
    varnam = Factory(:song_type, :name => "Varnam")
    a_song_in_geetham = Factory(:song, :name => "Gananatha", :song_type => geetham)
    a_song_in_varnam = Factory.build(:song, :name => "Gananatha", :song_type => varnam)
    a_song_in_varnam.valid?.should be_true
  end

  it "should not be able to create a song without name" do
    song = Factory.build(:song, :name => nil)
    song.valid?.should be_false
    song.errors.full_messages.to_sentence.should == "Name can't be blank"
  end

  it "should save with content" do
    song = Factory.build(:song)
    song_content_type = Factory(:song_content_type)
    song_contents = Hash.new
    3.times { |index| song_contents[index] = {:body => "song body #{index + 1}", :song_content_type_id => song_content_type.id } }
    song.save_with_contents(song_contents.values).should be_true
    song.reload
    song.song_contents.map { |song_content| song_content.body }.should == ["song body 1", "song body 2", "song body 3"]
  end

  it "should not save with content" do
    song = Factory.build(:song, :name => nil)
    song_content_type = Factory(:song_content_type)
    song_contents = Hash.new
    3.times { |index| song_contents[index] = {:body => "song body #{index + 1}", :song_content_type_id => song_content_type.id } }
    song.save_with_contents(song_contents.values).should be_false
  end

end
