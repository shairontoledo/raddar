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
    And I choose "Male"
    And I fill in "Date of birth" with "12/12/1992"
    And I fill in "Location" with "Winterfell / The North / Westeros"
    And I press "Register now!"
    Then I am redirected to the home page
    And I see the notice message "Nice! Please follow the instructions we've just sent to your e-mail address"

  Scenario: Registration without a location
    When I do not fill in "Location"
    Then I see no errors in the field "Location"

  Scenario Outline: Registration without a required field
    When I fill in "Name" with "<name>" 
    And I fill in "Email" with "<email>"
    And I fill in "Password" with "<password>"
    And I fill in "Password confirmation" with "<password>"
    And I choose "<gender>"
    And I fill in "Date of birth" with "<date of birth>"
    And I press "Register now!"
    Then I see the error message "Please review the problems below:"
    And I see the field "<invalid field>" with the error "can't be blank"

    Examples:
      | name   | email              | password | gender | date of birth | invalid field |
      |        | volmer@example.com | 123456   | Male   | 12/12/1992    | Name          |
      | volmer |                    | 123456   | Male   | 12/12/1992    | Email         |
      | volmer | volmer@example.com |          | Male   | 12/12/1992    | Password      |
      | volmer | volmer@example.com | 123456   |        | 12/12/1992    | Gender        |
      | volmer | volmer@example.com | 123456   | Male   |               | Date of birth |

  Scenario Outline: Registration with a valid name
    When I fill in "Name" with "<name>"
    And I press "Register now!"
    Then I see no errors in the field "Name"

    Examples:
      | name                 |
      | vol                  |
      | volmer               |
      | 123volmer            |
      | vol_mer              |
      | volmervolmervolmervo |

  Scenario Outline: Registration with Name in an invalid format
    When I fill in "Name" with "<name>"
    And I press "Register now!"
    And I see the error message "Please review the problems below:"
    And I see the field "Name" with the error "is invalid"

    Examples:
      | name       |
      | vol mer    |
      | v--ol-mer  |
      | v.o.l.m.er |
      | volm@r     |

  Scenario: Registration with a too short Name
    When I fill in "Name" with "vo"
    And I press "Register now!"
    Then I see the error message "Please review the problems below:"
    And I see the field "Name" with the error "is too short (minimum is 3 characters)"    

  Scenario: Registration with a too long Name
    When I fill in "Name" with "vovovovovovovovovovov"
    And I press "Register now!"
    Then I see the error message "Please review the problems below:"
    And I see the field "Name" with the error "is too long (maximum is 20 characters)"

  Scenario: Registration with a Name already in use
    Given there is an user registered with the following data:
      | name   |
      | volmer |
    When I fill in "Name" with "volmer"
    And I press "Register now!"
    Then I see the error message "Please review the problems below:"
    And I see the field "Name" with the error "is already taken"

  Scenario: Registration with Email in an invalid format
    When I fill in "Email" with "aninvalidemail"
    And I press "Register now!"
    Then I see the error message "Please review the problems below:"
    And I see the field "Email" with the error "is invalid"

  Scenario: Registration with an email already in use
    Given there is an user registered with the following data:
      | email              |
      | volmer@example.com |
    When I fill in "Email" with "volmer@example.com"
    And I press "Register now!"
    Then I see the error message "Please review the problems below:"
    And I see the field "Email" with the error "is already taken"

  Scenario: visitor is too young
    When I fill in "Date of birth" with a value younger than 13 years old
    And I press "Register now!"
    Then I see the error message "Please review the problems below:"
    And I see the field "Date of birth" with the error "You need to be at least 13 years old"

  Scenario: Registration with a wrong password confirmation
    When I fill in "Password" with "123456"
    And I fill in "Password confirmation" with "111111"
    And I press "Register now!"
    Then I see the error message "Please review the problems below:"
    And I see the field "Password" with the error "doesn't match confirmation"    


