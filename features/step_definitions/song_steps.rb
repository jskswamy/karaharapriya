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

Given /^I have a song "([^"]*)" with content "([^"]*)", song_type "([^"]*)", ragam "([^"]*)", talam "([^"]*)" and by composer "([^"]*)"$/ do |name, content, song_type_name, ragam_name, talam_name, composer_name|
  song_type = Factory(:song_type, :name => song_type_name)
  composer = Factory(:composer, :name => composer_name)
  ragam = Factory(:ragam, :name => ragam_name)
  talam = Factory(:talam, :name => talam_name)
  Factory(:song, :name => name, :song_type => song_type, :ragam => ragam, :talam => talam, :composer => composer, :content => content)
end

Given /^the song "([^"]*)" should be with content "([^"]*)", song_type "([^"]*)", ragam "([^"]*)", talam "([^"]*)", description "([^"]*)" and by composer "([^"]*)"$/ do |name, content, song_type_name, ragam_name, talam_name, description, composer_name|
  song_type = SongType.first(:conditions => {:name => song_type_name})
  composer = Composer.find_by_translated_field("name", composer_name)
  ragam = Ragam.find_by_translated_field("name", ragam_name)
  talam = Talam.find_by_translated_field("name", talam_name)
  song = Song.find_by_translated_field("name", name)

  song.song_type.should == song_type
  song.composer.should == composer
  song.ragam.should == ragam
  song.talam.should == talam
  song.description.should == description
  song.content.should == content
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
