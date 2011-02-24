# Scenario: Viewing the Sign Up Page
Given /^that I am an anonymous user on the root page$/ do
  @user = nil
  visit root_path
end

When /^I press the "(.+)" link$/ do |link|
  click_link (link)
end

Then /^I should be redirected to the page titled "Sign Up"$/ do
  page.should have_content("Sign Up")
end

# Scenario: Creating a New User
Given /^that I am on the "Sign Up" page$/ do
  visit signup_path
end


