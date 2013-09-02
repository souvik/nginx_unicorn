Feature: End user use their credential to login
  User can view their profile immediate after login

Scenario: As a User, I can signin from homepage
  Given I am in homepage
  And I click on "Signin"
  And I should see "login" form
  When I have entered my valid credentials:
    | email                | password      |
    | john.aflek@email.com | some-password |
  And I click on "login"
  Then I should see "my profile" page
