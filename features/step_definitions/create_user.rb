# Scenario: Viewing the Sign Up Page
Given /^that I am an anonymous user on the root page$/ do
  @user = nil
  visit root_path
end

When /^I press the "(.+)" link$/ do |link|
  click_link (link.downcase)
end

Then /^I should be redirected to the Sign Up page titled "(.*)"$/ do |title|
  page.should have_content("Sign Up")
end

# Scenario: Creating a New User
Given /^that I am an anonymous user$/ do
  @user = nil
end


