require 'spec_helper'

describe SongType do

  it "should not create duplicate" do
    varnam = Factory(:song_type, :name => "varnam")
    varnam_duplicate = Factory.build(:song_type, :name => "varnam")
    varnam_duplicate.valid?.should be_false
    varnam_duplicate.errors.full_messages.to_sentence.should == "Name has already been taken"
  end

end
