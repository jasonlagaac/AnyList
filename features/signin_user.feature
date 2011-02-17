Feature: Login User
  In order to create a user
  As a logged out user
  I want to login to my account
  
  Scenario: Visit Login Page
    Given that I am on the "root" page
    When I press the "login" link
    Then I should be redirected to the page titled "Login"
      
  Scenario: Login a valid user
    Given a user exists
    And I fill in "Username" with "george_washington"
    And I fill in "Password" with "foobar"
    And I press "Let Me Back In"
    Then I should see "george_washington"
    
  Scenario: Login an invalid user
    Given that I am on the "login" page
    And I fill in "Username" with "an_invalid_user"
    And I fill in "Password" with "an_invalid_user"
    And I press "Let Me Back In"
    Then I should see "Invalid email/password combination"
    
  Scenario: Log Out a valid user
    Given a user exists
    And I am logged in
    When I press the "signout" link    
    Then I should see "WishList"
  