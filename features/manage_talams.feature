Feature: Manage talams
  In order to create, delete and update the talams
  As a user
  I want to add, update and delete the talam

  @javascript
  Scenario: Create new talam
    Given I am on the new talam page
    And I fill in the following:
      | talam_name | Adi |
      | talam_avartanam | 1 0 U |
      | talam_laghu_length | 4 |
      | talam_description | New Talam |
    And I press "Submit"
    Then I should be on the talams_list page
    And the talam "Adi" should be with avartanam "1 0 U", laghu_length 4 and description "New Talam"

  @javascript
  Scenario: Should not create a talam with duplicate name
    Given I have a talam "Adi"
    When I am on the new talam page
    And I fill in the following:
      | talam_name | Adi |
      | talam_avartanam | 1 0 U |
      | talam_laghu_length | 4 |
      | talam_description | Talam with 8 notes |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_name" field should have error "is already taken"

  @javascript
  Scenario: Should not create a talam with duplicate avartanam and laghu_length
    Given the following talams:
      | name | avartanam | laghu_length |
      | Adi | 1 0 U | 4 |
    When I am on the new talam page
    And I fill in the following:
      | talam_name | Mohanam |
      | talam_avartanam | 1 0 U |
      | talam_laghu_length | 4 |
      | talam_description | Talam with 8 notes |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_laghu_length" field should have error "is already taken"

  @javascript
  Scenario: Should not create talam without name
    Given I am on the new talam page
    And I fill in the following:
      | talam_avartanam | 1 0 U |
      | talam_laghu_length | 4 |
      | talam_description | New Talam |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_name" field should have error "can't be blank"

  @javascript
  Scenario: Should not create talam without avartanam
    Given I am on the new talam page
    And I fill in the following:
      | talam_name | Adi |
      | talam_laghu_length | 4 |
      | talam_description | New Talam |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_avartanam" field should have error "can't be blank"

  @javascript
  Scenario: Should not create talam without laghu_length
    Given I am on the new talam page
    And I fill in the following:
      | talam_name | Adi |
      | talam_avartanam | 1 0 U |
      | talam_description | New Talam |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_laghu_length" field should have error "can't be blank"

  @javascript
  Scenario: Should not create talam without description
    Given I am on the new talam page
    And I fill in the following:
      | talam_name | Adi |
      | talam_avartanam | 1 0 U |
      | talam_laghu_length | 4 |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_description" field should have error "can't be blank"

  @javascript
  Scenario: Edit a talam
    Given the following talams:
      | name | avartanam | laghu_length |
      | Adi | 1 0 U | 4 |
      | Roopagam | 1 1 1 0 U  | 5 |
    When I am on the talams_list page
    And I follow "Adi"
    Then I fill in the following:
      | talam_name | New Adi |
      | talam_avartanam | 1 1 0 U |
      | talam_laghu_length | 6 |
      | talam_description | Updated Talam |
    And I press "Submit"
    Then I should be on the talams_list page
    And the talam "New Adi" should be with avartanam "1 1 0 U", laghu_length 6 and description "Updated Talam"
