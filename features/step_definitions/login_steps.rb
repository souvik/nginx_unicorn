Given /^I am in homepage$/ do
  visit(root_path)
end

And /^I click on "([^"]*)"$/ do |link|
  click_link(link)
end
