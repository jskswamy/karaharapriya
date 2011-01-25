require "spec_helper"

describe ApplicationHelper do

  it "should render necessary html for auto_complete" do
    expected_html = "<div data-auto-complete=\"true\">\n  <div class=\"title\">\n    <label for=\"talam\">Talam</label>\n  </div>\n  <div class=\"input\" data-auto-complete-url=\"url\">\n    <input data-auto-complete-hidden=\"true\" id=\"song_talam_id\" name=\"song[talam_id]\" type=\"hidden\" />\n    <input data-auto-complete-input=\"true\" id=\"talam\" name=\"talam\" type=\"text\" />\n    <div class=\"auto_completion\" data-auto-complete-completion=\"true\"></div>\n  </div>\n</div>\n"
    rendered_html = auto_complete({:label => "talam", :name => "song[talam_id]", :url => "url"})
    rendered_html.should == expected_html
  end

end
