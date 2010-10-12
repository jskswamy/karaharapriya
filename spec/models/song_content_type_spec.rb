require 'spec_helper'

describe SongContentType do

  it "should not create duplicate entry with same name" do
    pallavi = Factory(:song_content_type, :name => "Pallavi")
    another_pallavi = Factory.build(:song_content_type, :name => "Pallavi")
    another_pallavi.valid?.should be_false
  end

end
