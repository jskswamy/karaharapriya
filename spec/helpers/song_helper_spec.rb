require 'spec_helper'

describe SongsHelper do

  it "should render the editor" do
    expected = "<div class='class' data-song-editor-url='url' data-song-editor='true' data-song-type='type'>\nbody\n</div>\n"
    rendered_text = editor(:url => "url", :song_type => "type", :class => 'class') { "body" }
    rendered_text.should == expected
  end

end
