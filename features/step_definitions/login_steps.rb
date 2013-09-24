Given /^I am in homepage$/ do
  visit(root_path)
end

And /^I click on "([^"]*)"$/ do |link|
  click_link(link)
end

And /^I should see "([^"]*)" form$/ do |form_name|
  find(:xpath, "//div[@class='container']//div[@class='#{form_name}']/form")
end

When /^I have entered my valid credentials:$/ do |table|
  table.rows.each do |email, password|
    step %{I fill in "email" with "#{email}"}
    step %{I fill in "password" with "#{password}"}
  end
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, with: value)
end

Then /^I should see welcome message for "([^"]*)"$/ do |name|
  find(:xpath, "//div[@id='welcome-message']/h3[contains(text(), \"Welcome #{name.capitalize}!\")]")
end
