Given /^the following composers:$/ do |composers|
  composers.hashes.each { |hash| Factory(:composer, hash) }
end

When /^I delete the (\d+)(?:st|nd|rd|th) composers$/ do |pos|
  visit composers_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following composers:$/ do |expected_composers_table|
  expected_composers_table.diff!(tableish('table tr', 'td,th'))
end

Then /^the composer "([^"]*)" should be with century "([^"]*)" and info "([^"]*)"$/ do |name, century, info|
  composer = Composer.find_by_translated_field("name", name)
  composer.should_not be_blank
  composer.century.should == century
  composer.info.should == info
end
