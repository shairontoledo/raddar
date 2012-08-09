require 'pp'

Given /^I am on the (.*?) page$/ do |page_name|
  visit path_to(page_name)
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in field, with: value
end

When /^I choose "(.*?)"$/ do |value|
  choose value 
end

When /^I click on "(.*?)"$/ do |clickable|
  click_on clickable
end

Then /^I am redirected to the (.*?) page$/ do |page_name|
  #pp body
  pp 'volmer'
  pp @integration_session.headers
end

Then /^I see the (.*?) message "(.*?)"$/ do |type, message|
  page.should have_css("div#flash_#{type}", text: message, visible: true)
end