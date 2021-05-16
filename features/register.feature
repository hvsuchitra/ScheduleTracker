# feature/register.feature


Feature: Register
  As a potential member
  So that can see information about movies that interest me
  I want register for the RottenPotatoes application
  
Background: profiles in databasea

  Given the following profiles exists:
  | primary_language|secondary_language|favorite_movie|worst_movie|favorite_genre|user_id|
  | English         | Music            | Blade Runner |Ishtar     |SciFi         |       |    

  
@omniauth_test1
Scenario: Register
  When I go to the landing page
  #Given I am on the landing Page
  #And I press "Register"
  And I press "Register or Login with Github"
  And I should see "Welcome Tester SUNY! You have signed up via github."
  

@omniauth_test2
Scenario:  Can't Register without SUNY ID
  When I go to the landing page
  #And I press "Register"
  And I press "Register or Login with Github"
  #And I press "Register with GitHub"
  And I should see "ActiveRecord::RecordInvalid: Validation failed: Email must be for Binghamton University"