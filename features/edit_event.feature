Feature: Edit Event
  In order to edit an event
  As an existing user
  I want to edit a selected event

  Scenario: Edit Existing Event
    Given a user exists
    And I am logged in
    When I fill in "event_title" with "Christmas"
    And I press "Create my event"
    Then I should see "Christmas"
    When I fill in "edit_event_title" with "Guy Fawkes"
    And I press "Change Event"
    Then I should see "Guy Fawkes"
