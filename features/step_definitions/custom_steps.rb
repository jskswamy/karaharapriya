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
  error_div.text.should == error
end
