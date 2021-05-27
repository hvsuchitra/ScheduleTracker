Given /the following profiles exist/ do |profiles_table|
  profiles_table.hashes.each do |profile|
    Profile.create profile
  end 
end

Then(/^I should see the welcome message$/) do
  expect(page).to have_content("Welcome to Schedule Tracker")
end

Given /the following authorizations exist/ do |authorizations_table|
  authorizations_table.hashes.each do |authorization|
    Authorization.create! authorization
   # puts 'create authorization'
  #  p Authorization.all
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
   # puts 'create user'
  #  p User.all
  end
end
  
  
  Given /the following schedules exist/ do |schedules_table|
  schedules_table.hashes.each do |schedule|
    Schedule.create! schedule
  end 
end

Then /^I will see "([^"]*)"$/ do |message|
  #puts page.body # <---
  expect(page.body).to have_content(message)
end

Given /I am logged into ScheduleTracker/ do
  steps %Q{
    Given I am on the ScheduleTracker Landing Page   
    And I press "Register or Login with Github"
    Then I will see "Given Slots"
    And I am on the ScheduleTracker Home Page
    }
end


Then /^the Availability of "([^"]*)" should be "([^"]*)"/ do |name, availability|
	if page.respond_to? :should
    page.should have_content(name)
  else
    assert page.has_content?(name)
  end
	
	if page.respond_to? :should
    page.should have_content(availability)
  else
    assert page.has_content?(availability)
  end
end
