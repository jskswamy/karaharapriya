Feature: Manage composers
  In order to create, delete and update the composers
  As a user
  I want to add, update and delete the composer

  @javascript
  Scenario: Should not be allowed to create composer without sign in
    When I am on the new composer page
    Then I should be on the sign_in page

  @javascript
  Scenario: Should not be allowed to edit the composer without sign in
    Given the following composers:
      | name | century |
      | Thyagarajar | 20th |
      | Boominathar | 21st |
    When I am on the composers_list page
    And I follow "edit" within "tbody > tr:nth-child(1)"
    Then I should be on the sign_in page

  @javascript
  Scenario: Create new composer
    Given I am on the new composer page
    And I have a signed as a normal user
    And I fill in the following:
      | composer_name | Thyagarajar |
      | composer_century | 19th |
    And I press "Submit"
    Then I should be on the composers_list page
    And the composer "Thyagarajar" should be with century "19th"

  @javascript
  Scenario: Should not create a composer with duplicate name
    Given I have a composer "Thyagarajar"
    And I have a signed as a normal user
    When I am on the new composer page
    And I fill in the following:
      | composer_name | Thyagarajar |
      | composer_century | 19th |
    And I press "Submit"
    Then I should be on the new composer page
    And I should see "Please review the highlighted fields"
    And "composer_name" field should have error "is already taken"

  @javascript
  Scenario: Should not create composer without name
    Given I am on the new composer page
    And I have a signed as a normal user
    And I fill in the following:
      | composer_century | 19th |
    And I press "Submit"
    Then I should be on the new composer page
    And I should see "Please review the highlighted fields"
    And "composer_name" field should have error "can't be blank"

  @javascript
  Scenario: Edit a composer
    Given the following composers:
      | name | century |
      | Thyagarajar | 20th |
      | Boominathar | 21st |
    And I have a signed as a normal user
    When I am on the composers_list page
    And I follow "edit" within "tbody > tr:nth-child(1)"
    Then the "composer_name" field should contain "Thyagarajar"
    And the "composer_century" field should contain "20th"
    Then I fill in the following:
      | composer_name | Muthuswamy |
      | composer_century | 19th |
    And I press "Submit"
    Then I should be on the composers_list page
    And the composer "Muthuswamy" should be with century "19th"

  Scenario: Show a composer
    Given the following composers:
      | name | century |
      | Thyagarajar | 20th |
      | Boominathar | 21st |
    And I am on the composers_list page
    When I follow "Thyagarajar"
    Then I should be on composer Thyagarajar's show page
    And I should see "Composer Thyagarajar"
    And I should see "Name"
    And I should see "Thyagarajar"
    And I should see "Century"
    And I should see "20th"
