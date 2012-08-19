Given /^I am on the (.*?) page$/ do |page_name|
  visit path_to(page_name)
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in field, with: value
end

When /^I do not fill in "(.*?)"$/ do |field|
  fill_in field, with: ''
end

When /^I choose "(.*?)"$/ do |value|
  choose value unless value.blank?
end

When /^I click on "(.*?)"$/ do |clickable|
  click_on clickable
end

When /^I press "(.*?)"$/ do |button|
  click_button button
end

When /^I check "(.*?)"$/ do |checkbox|
  check checkbox
end

Then /^I am redirected to the (.*?) page$/ do |page_name|
  current_path.should == path_to(page_name)
end

Then /^I see the (.*?) message "(.*?)"$/ do |type, message|
  have_alert(message, type).should be_true
end

Then /^I see the field "(.*?)" with the error "(.*?)"$/ do |field, message|
  find('div.control-group', text: field).should have_css("span.help-inline", text: message, visible: true)
end

Then /^I see no errors in the field "(.*?)"$/ do |field|
  find('div.control-group', text: field).should_not have_css('span.help-inline', visible: true)
end