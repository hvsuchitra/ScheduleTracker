Feature: Welcome

  As a developer
  I want our users to be greeted when they visit our site
  So that they have a better experience
  
Scenario: User sees the welcome message
  When I go to the landing page
  And I press "About"
  Then I should see "About Schedule Tracker"