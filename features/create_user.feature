Feature: Create User
	In order to create a user
	As an anonymous user
	I want to create a new user
	
	Scenario: Visit Create User Page
		Given that I am an anonymous user on the root page
		When I press the "signup" link
		Then I should be redirected to the page titled "Sign Up"
		
	Scenario Outline: Create a valid or invalid user
		Given that I am on the "Sign Up" page
		  When I fill in "Username" with "<username>"
  	  And I fill in "Email" with "<email>"
  	  And I fill in "Password" with "<password>"
  	  And I fill in "Password Confirmation" with "<password_confirmation>"
  	  And I press "Create My Account"
  	  Then I should see "<result>"
  	  
  Examples:
  	| username       | email            | password         | password_confirmation | result                                         |
    | a_test_user    | test@example.com | aTestP4ssword_   | aTestP4ssword_        | a_test_user                                    |
    | a failing user | fail@Example     | aFailingPassword | aFlngPassword         | Please check the items that you have entered   |
	  