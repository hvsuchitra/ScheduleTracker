Feature: Schedules Add, Edit, Delete
  As a registered member
  So that I can use the Schedule Tracker
  I want to add, edit, and delete schedules from the Schedule Tracker Website
  
Background: authorization and user in database
#Background: schedules in database
  
  Given the following authorizations exist:
  | provider|uid    |user_id|
  | github  |123456 |1      | 
  
  Given the following users exist:
  |name        | email                 |
  |Tester SUNY| stester@binghamton.edu |
  
  Given the following schedules exist:
  | name   | date       |
  | Subbu  | 2021-06-29 |
  | Test   | 2021-02-21 |        
  
  Given I am logged into ScheduleTracker
  
  
@new_schedule
Scenario: add Schedule
  Given I am on the New Schedule Page
  And I fill in "Name" with "Test"
  And I fill in "Date" with "2021-02-21"
  And I fill in "Start Time" with "6:00"
  And I fill in "End Time" with "10:00"
  And I select "Available" from "Availability"
  And I press "Save Changes"
  Then the Availability of "Test" should be "Available"
  
@edit_schedule
Scenario: change Schedule
  Given I am on the edit Schedule page for "Subbu"
  And I fill in "Name" with "Subbu"
  And I fill in "Date" with "2021-02-21"
  And I fill in "Start Time" with "6:00"
  And I fill in "End Time" with "10:00"
  And I select "Not Available" from "Availability"
  And I press "Update Slot Info"
  Then I should see "Subbu was successfully updated"
  
@delete_schedule
Scenario: delete Schedule
  Given I am on the show Schedule page for "Subbu"
  And  I follow "Delete"
  Then I should see "Slot 'Subbu' deleted"