Feature: User sign out
  In order to protect my account from unauthorized access
  As an user
  I want to be able to sign out

  Scenario: Successful sign out
    Given I am authenticated as "volmer"
    When I click on "volmer"
    And I click on "Sign out"
    Then I am redirected to the home page
    And I see the notice message "Signed out successfully."