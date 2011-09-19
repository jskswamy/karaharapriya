Feature: Manage composers
  In order to create, delete and update the composers
  As a user
  I want to add, update and delete the composer

  Scenario: Should navigate to account settings
    Given I have a signed as a normal user
    And I am on the home page
    And I should see "Account Settings"
    When I follow "Account Settings"
    Then I should be on the manage accounts page

  Scenario: Should be able to logout
    Given I have a signed as a normal user
    And I am on the home page
    And I should see "Logout"
    When I follow "Logout"
    Then I should be on the home page
    And I should see "Signed out successfully"
