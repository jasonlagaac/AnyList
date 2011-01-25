Given /^that I am on the "root" page$/ do 
  visit root_path
end

Given /^that I am on the "login" page$/ do 
  visit signin_path
end

Then /^I should be redirected to the page titled "Login"$/ do
  page.should have_content("Login")
end

