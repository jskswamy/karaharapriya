Given /^the following talams:$/ do |talams|
  talams.hashes.each { |hash| Factory(:talam, hash) }
end

When /^I delete the (\d+)(?:st|nd|rd|th) talams$/ do |pos|
  visit talams_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following talams:$/ do |expected_talams_table|
  expected_talams_table.diff!(tableish('table tr', 'td,th'))
end

Then /^the talam "([^"]*)" should be with avartanam "([^"]*)" and laghu_length (\d+)$/ do |name, avartanam, laghu_length|
  talam = Talam.find_by_translated_field("name", name)
  talam.should_not be_nil
  talam.avartanam.should == avartanam
  talam.laghu_length.should == laghu_length.to_i
end
