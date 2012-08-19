Feature: User sign in
  In order to get access to protected sections
  As an user
  I want to be able to sign in

  Background:
    Given I am registered with the following data:
      | name   | email              | password |
      | volmer | volmer@example.com | 123456   |
    And I am not authenticated
    And I am on the new user session page

  Scenario Outline: Successfull sign in
    When I fill in "Name or email" with "<login>"
    And I fill in "Password" with "123456"
    And I check "Remember me"
    And I press "Sign in"
    Then I am signed in as "volmer"
    And I am redirected to the home page
    And I see the notice message "Welcome!"
  
    Examples:
      | login              |
      | volmer@example.com |
      | volmer             |

  Scenario Outline: Sign in with invalid credentials
    When I fill in "Name or email" with "<login>"
    And I fill in "Password" with "<password>"
    And I press "Sign in"
    Then I see the error message "Invalid name/email or password."
  
    Examples:
      | login              | password |
      | volmer@example.com | 111111   |
      | volmer             | 111111   |
      | vol@example.com    | 123456   |
      | volmerius          | 123456   |
      | volmer@example.com |          |
      | volmer             |          |
      |                    | 123456   |
      |                    |          |
      | volmerius          | 111111   |