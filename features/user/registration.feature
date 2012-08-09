Feature: User registration
  In order to become a member to this awesome community
  As a visitor
  I want to register

  Background:
    Given I am not authenticated
    And I am on the new user registration page

  Scenario: Successful registration
    When I fill in "Name" with "volmer" 
    And I fill in "Email" with "volmer@example.com"
    And I fill in "Password" with "123456"
    And I fill in "Password confirmation" with "123456"
    And I choose "male"
    And I fill in "Date of birth" with "12/12/1992"
    And I click on "Register now!"
    Then I am redirected to the home page
    And I see the notice message "Nice! Please follow the instructions we've just sent to your e-mail address"


