Feature: Create Item
   In order to create an item
   As a logged in user
   With an existing event 
   I want to create an Item
   
   Scenario: Create Item
     Given a user exists
     And I am logged in
     When I fill in "event_title" with "Christmas"
     And I press "Create my event"
     Then I should see "Christmas"
     When I fill in "item_name" with "Macbook"
     And I fill in "item_description" with "Full of Awesome"
     When I press "Add my item"
     Then I should see "Macbook"