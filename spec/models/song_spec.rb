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

end
