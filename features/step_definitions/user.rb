Given /^I am not authenticated$/ do
  visit path_to('home')
  unless find('div.navbar').has_content?('Sign in')
    step 'I open my user menu'
    click_link 'Sign out'
  end
end

Given /^I am authenticated as "(.*?)"$/ do |name|
  password = 123456
  user = FactoryGirl.create :user, name: name, password: password 
  step "I sign in with the name \"#{name}\" and the password \"#{password}\""
end

Given /^I sign in with the name "(.*?)" and the password "(.*?)"$/ do |name, password|
  step 'I am on the new user session page'
  step "I fill in \"Name or email\" with \"#{name}\""
  step "I fill in \"Password\" with \"#{password}\""
  step 'I press "Sign in"'
end

When /^I fill in "(.*?)" with a value younger than (.*?) years old$/ do |field, age|
  age = age.to_i
  fill_in field, with: (I18n.l(age.years.ago.to_date))
end

When 'I open my user menu' do
  click_link 'current_user_data'
end

Given /^there are users registered with the following data:$/ do |table|
  table.hashes.each do |line|
    @user = FactoryGirl.build :user
    line.each do |key, value|
      @user[key.strip.to_sym] = value.strip
    end
    @user.confirm!
    @user.save!
  end
end

Given /^there is an user registered with the following data:$/ do |table|
  step 'there are users registered with the following data:', table
end

Given /^I am registered with the following data:$/ do |table|
  step 'there is an user registered with the following data:', table
end

Then /^I am signed in as "(.*?)"$/ do |name|
  find('div.navbar').should have_content(name)
  find('div.navbar').should_not have_content('Sign in')
end

Then /^my password is now "(.*?)"$/ do |password|
  User.find(@user.name).valid_password?(password).should be_true
end