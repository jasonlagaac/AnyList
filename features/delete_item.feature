Feature: Delete Item
   In order to delete an item
   As a logged in user
   With an existing event 
   I want to delete an Item
   
   Scenario: Delete Item
     Given a user exists
     And I am logged in
     When I fill in "event_title" with "Christmas"
     And I press "Create my event"
     Then I should see "Christmas"
     When I fill in "item_name" with "Macbook"
     And I fill in "item_description" with "Full of Awesome"
     When I press "Add my item"
     Then I should see "Macbook"
     When I press the "delete_item" link
     Then I should not see "Macbook"