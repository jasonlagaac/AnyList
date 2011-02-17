Feature: Event Handling
  In order to create an event
  As a logged in user
  I want to create, edit and 
  delete my created events
  
  Scenario: Create Event
    Given a user exists
    And I am logged in
    When I fill in "event_title" with "Christmas"
    And I press "Create my event"
    Then I should see "Christmas"
  
  Scenario: Delete Event
    Given a user exists
    And I am logged in
    
    When I fill in "event_title" with "Christmas"
    And I press "Create my event"
    Then I should see "Christmas"
    Then show me the page
    When I press the "delete" link
    Then I should not see "Christmas"