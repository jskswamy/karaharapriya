Given /^the following ragams:$/ do |ragams|
  ragams.hashes.each { |hash| Factory(:ragam, hash) }
end

When /^I delete the (\d+)(?:st|nd|rd|th) ragams$/ do |pos|
  visit ragams_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following ragams:$/ do |expected_ragams_table|
  expected_ragams_table.diff!(tableish('table tr', 'td,th'))
end

Then /^the ragam "([^"]*)" should be with arohana "([^"]*)", avarohana "([^"]*)", parent ragam "([^"]*)" and description "([^"]*)"$/ do |name, arohana, avarohana, parent_ragam_name, description|
  parent_ragam = Ragam.find_by_translated_field("name", parent_ragam_name)
  ragam = Ragam.find_by_translated_field("name", name)
  ragam.should_not be_nil
  ragam.arohana.should == arohana
  ragam.avarohana.should == avarohana
  ragam.parent.should == parent_ragam
  ragam.description.should == description
end

Given /^I have a ragam "([^"]*)" with arohana "([^"]*)", avarohana "([^"]*)", parent ragam "([^"]*)" and description "([^"]*)"$/ do |name, arohana, avarohana, parent_ragam_name, description|
  parent_ragam = Ragam.find_by_translated_field("name", parent_ragam_name)
  Factory(:ragam, :name => name, :arohana => arohana, :avarohana => avarohana, :parent => parent_ragam, :description => description)
end
