Feature: Change password
  In order to improve my security
  As an user
  I want to change my password


  Background:
    Given I am registered with the following data:
      | name   | password |
      | volmer | 123456   |
    And I sign in with the name "volmer" and the password "123456"
    And I open my user menu
    And I click on "Edit account"
    And I click on "Change password"

  Scenario: Successful password change
    When I fill in "Password" with "mypassword66"
    And I fill in "Password confirmation" with "mypassword66"
    And I fill in "Current password" with "123456"
    And I press "Change password"
    Then I see the notice message "Password changed!"
    And my password is now "mypassword66"

  Scenario: Wrong password confirmation
    When I fill in "Password" with "123456"
    And I fill in "Password confirmation" with "111111"
    And I press "Change password"
    Then I see the error message "Please review the problems below:"
    And I see the field "Password" with the error "doesn't match confirmation"

  Scenario: Wrong current password
    When I fill in "Current password" with "111111"
    And I press "Change password"
    Then I see the error message "Please review the problems below:"
    And I see the field "Current password" with the error "is invalid"   

  Scenario Outline: Blank required field
    When I do not fill in "<field>"
    And I press "Change password"
    Then I see the error message "Please review the problems below:"
    And I see the field "<field>" with the error "can't be blank" 

    Examples:
      | field            |
      | Password         |
      | Current password |
