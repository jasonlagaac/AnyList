Feature: Edit User
  In order to edit a user details
  As an existing user
  I want to edit my details
  
  Scenario: View User Edit Page
    Given a user exists
    And I am logged in
    When I press the "Account Settings" link
    Then I should see "Edit Your Details"
    
    
  Scenario: Edit User Password
    Given a user exists
    And I am logged in
    When I press the "Account Settings" link
    Then I should see "Edit Your Details"
    When I fill in "Password" with "changedit"
    And I fill in "Password Confirmation" with "changedit"
    And I press "Change My Password"
    Then I should see "Password Successfully Changed"

  Scenario: Edit User Information
    Given a user exists
    And I am logged in
    When I press the "Account Settings" link
    Then I should see "Edit Your Details"
    When I fill in "Location" with "Sydney"
    And I fill in "Bio" with "I am a developer from Sydney, Australia"
    And I press "Update My Details"
    Then I should see "Details Successfully Updated"
