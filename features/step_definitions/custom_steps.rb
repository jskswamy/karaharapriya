Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  field = find_field(field)
  option_xpath = "//option[text()='#{value}']"
  option = field.has_selector?(:xpath, option_xpath) ? field.find(:xpath, option_xpath) : nil
  option.should_not be_nil
  option.selected?.should be_true
end

Then /^"([^"]*)" field should have error "([^"]*)"$/ do |field_name, error|
  field = find_field(field_name)
  field_label = find(:css, "label.error[for='" + field_name + "']")
  field.should_not be_nil
  field_label.should_not be_nil
  field.click
  error_div = find(:css, "div.error")
  error_div.should_not be_nil
  error_div.text.should == error
end

When /^I fill in "([^"]*)" wysiwyg editor with "([^"]*)"$/ do |editor_name, html|
  script = <<-JS
    var editor = YUILibrary.getEditor("#{editor_name}");
    editor.setEditorHTML("#{html}");
  JS
  page.execute_script(script);
end

Then /^the "([^"]*)" wysiwyg editor should contain "([^"]*)"$/ do |editor_name, html|
  script = <<-JS
    YUILibrary.getEditor("#{editor_name}").getEditorHTML();
  JS
  editor_html = page.evaluate_script(script);
  editor_html.should == html
end

Given /^I have a signed as a normal user$/ do
  Factory(:user, :name => "tom", :email => "tom@disney.com", :password => "password")
  Given "I am on the sign_in page"
  And "I fill in \"user_email\" with \"tom@disney.com\""
  And "I fill in \"user_password\" with \"password\""
  And "I press \"Sign in\""
end

When /^I follow "([^"]*)" within "([^"]*)"$/ do |link, parent|
  within parent do
    click_link(link)
  end
end
