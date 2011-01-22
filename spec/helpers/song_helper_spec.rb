require 'spec_helper'

describe SongsHelper do

  it "should render the editor" do
    expected = "<div class='class' data-song-editor='true' data-song-type='type' data-song-editor-url='url'>\n  body\n</div>\n"
    rendered_text = editor(:url => "url", :song_type => "type", :class => 'class') do
      "body"
    end
    rendered_text.should == expected
  end

end
