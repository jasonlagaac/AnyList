Feature: Delete Event
  In order to delete an event
  As a logged in user
  With an existing event
  I want to delete an event
  
  Scenario: Delete Event
    Given a user exists
    And I am logged in
    
    When I fill in "event_title" with "Christmas"
    And I press "Create my event"
    Then I should see "Christmas"
    When I press the "delete_event" link
    Then I should not see "Christmas"
