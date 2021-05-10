Given /the following profiles exist/ do |profiles_table|
  profiles_table.hashes.each do |profile|
    Profile.create profile
  end 
end

Then(/^I should see the welcome message$/) do
  expect(page).to have_content("Welcome to Rotten Potatoes!")
end

Then /^I will see "([^"]*)"$/ do |message|
  puts page.body # <---
  expect(page.body).to have_content(message)
end

Given /I am logged into ScheduleTracker/ do
  steps %Q{
    Given I am on the ScheduleTracker Landing Page   
    And I press "Register or Login with Github"
    Then I will see "All Movies"
    And I am on the ScheduleTracker Home Page
    }
end

Given /the following authorizations exist/ do |authorizations_table|
  authorizations_table.hashes.each do |authorization|
    Authorization.create! authorization
    puts 'create authorization'
    p Authorization.all
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create! user
    puts 'create user'
    p User.all
  end
end