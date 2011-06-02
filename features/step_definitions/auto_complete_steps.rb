Then /^I should see the following autocomplete options:$/ do |table|
  And "I wait for 1 seconds"
  table.raw.each do |row|
    option_name = row[0]
    raise "#{option_name} is not found in autocomplete options" unless has_selector?(:xpath, "//a[text()='#{option_name}']")
  end
end

Then /^I should not see the following autocomplete options:$/ do |table|
  And "I wait for 1 seconds"
  table.raw.each do |row|
    option_name = row[0]
    raise "#{option_name} is found in autocomplete options" unless has_no_selector?(:xpath, "//a[text()='#{option_name}']")
  end
end

Then /^I wait for (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end

Then /^I should see "([^"]*)" in autocomplete option$/ do |link_text|
  has_selector?(:xpath, "//a[text()='#{link_text}']")
end

When /^I click on the "([^"]*)" autocomplete option$/ do |link_text|
  find(:xpath, "//a[text()='#{link_text}']").click
end

When /^I choose "([^"]*)" as "([^"]*)" using auto complete$/ do |text, selector|
  And "I fill in \"#{selector}\" with \"#{text}\""
  And "I wait for 1 seconds"
  And "I click on the \"#{text}\" autocomplete option"
end
