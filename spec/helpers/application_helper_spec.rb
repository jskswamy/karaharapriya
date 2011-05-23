require "spec_helper"

describe ApplicationHelper do

  it "should render necessary html for auto_complete" do
    form_helper = mock
    form_helper.should_receive(:hidden_field).with("song[talam_id]", {"data-auto-complete-hidden"=> "true"})
    form_helper.should_receive(:text_field).with("talam", {"data-auto-complete-input"=> "true"})

    expected_html = "<div data-auto-complete=\"true\">\n  <div class=\"title\">\n    <label for=\"talam\">Talam</label>\n  </div>\n  <div class=\"input\" data-auto-complete-url=\"url\">\n    \n    \n    <div class=\"auto_completion\" data-auto-complete-completion=\"true\" style=\"display: none\"></div>\n  </div>\n</div>\n"

    rendered_html = auto_complete({:label => "talam", :field_name => "talam", :name => "song[talam_id]", :url => "url", :form_helper => form_helper })
    rendered_html.should == expected_html
  end

end
