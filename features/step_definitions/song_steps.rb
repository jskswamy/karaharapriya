Given /^I have a song type "([^"]*)"$/ do |name|
  Factory(:song_type, :name => name)
end

Given /^I have a composer "([^"]*)"$/ do |name|
  Factory(:composer, :name => name)
end

Given /^I have following composers:$/ do |table|
  table.raw.each do |row|
    Factory(:composer, :name => row[0])
  end
end

Given /^I have a ragam "([^"]*)"$/ do |name|
  Factory(:ragam, :name => name)
end

Given /^I have following ragams:$/ do |table|
  table.raw.each do |row|
    Factory(:ragam, :name => row[0])
  end
end

Given /^I have a talam "([^"]*)"$/ do |name|
  Factory(:talam, :name => name)
end

Given /^I have following talams:$/ do |table|
  table.raw.each do |row|
    Factory(:talam, :name => row[0])
  end
end

Given /^the following songs:$/ do |songs|
  Song.create!(songs.hashes)
end

Given /^I have a "([^"]*)" as song type$/ do |name|
  Factory(:song_type, :name => name)
end

When /^I delete the (\d+)(?:st|nd|rd|th) song$/ do |pos|
  visit songs_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following songs:$/ do |expected_songs_table|
  expected_songs_table.diff!(tableish('table tr', 'td,th'))
end
