Feature: Create Event
  In order to create an event
  As a logged in user
  I want to create a new event
  
  Scenario: Create Event
    Given a user exists
    And I am logged in
    When I fill in "event_title" with "Christmas"
    And I press "Create my event"
    Then I should see "Christmas"
