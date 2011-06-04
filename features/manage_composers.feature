Feature: Manage composers
  In order to create, delete and update the composers
  As a user
  I want to add, update and delete the composer

  @javascript
  Scenario: Create new composer
    Given I am on the new composer page
    And I fill in the following:
      | composer_name | Thyagarajar |
      | composer_century | 19th |
      | composer_info | New composer |
    And I press "Submit"
    Then I should be on the composers_list page
    And the composer "Thyagarajar" should be with century "19th" and info "New composer"

  @javascript
  Scenario: Should not create a composer with duplicate name
    Given I have a composer "Thyagarajar"
    When I am on the new composer page
    And I fill in the following:
      | composer_name | Thyagarajar |
      | composer_century | 19th |
      | composer_info | New composer |
    And I press "Submit"
    Then I should be on the new composer page
    And I should see "Please review the highlighted fields"
    And "composer_name" field should have error "is already taken"

  @javascript
  Scenario: Should not create composer without name
    Given I am on the new composer page
    And I fill in the following:
      | composer_century | 19th |
      | composer_info | New composer |
    And I press "Submit"
    Then I should be on the new composer page
    And I should see "Please review the highlighted fields"
    And "composer_name" field should have error "can't be blank"

  @javascript
  Scenario: Should not create composer without info
    Given I am on the new composer page
    And I fill in the following:
      | composer_name | Thyagarajar |
      | composer_century | 19th |
    And I press "Submit"
    Then I should be on the new composer page
    And I should see "Please review the highlighted fields"
    And "composer_info" field should have error "can't be blank"

  @javascript
  Scenario: Edit a composer
    Given the following composers:
      | name | century | info |
      | Thyagarajar | 20th | Great composer |
      | Boominathar | 21st | Another Great composer |
    When I am on the composers_list page
    And I follow "Thyagarajar"
    Then I fill in the following:
      | composer_name | Muthuswamy |
      | composer_century | 19th |
      | composer_info | Updated composer |
    And I press "Submit"
    Then I should be on the composers_list page
    And the composer "Muthuswamy" should be with century "19th" and info "Updated composer"
