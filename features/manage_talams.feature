Feature: Manage talams
  In order to create, delete and update the talams
  As a user
  I want to add, update and delete the talam

  @javascript
  Scenario: Should not be allowed to create talam without sign in
    When I am on the new talam page
    Then I should be on the sign_in page

  @javascript
  Scenario: Should not be allowed to edit talam without sign in
    Given the following talams:
      | name | avartanam | laghu_length |
      | Adi | 1 0 U | 4 |
      | Roopagam | 1 1 1 0 U  | 5 |
    When I am on the talams_list page
    And I follow "edit" within "tbody > tr:nth-child(1)"
    Then I should be on the sign_in page

  @javascript
  Scenario: Create new talam
    Given I am on the new talam page
    And I have a signed as a normal user
    And I fill in the following:
      | talam_name | Adi |
      | talam_avartanam | 1 0 U |
      | talam_laghu_length | 4 |
    And I press "Submit"
    Then I should be on the talams_list page
    And the talam "Adi" should be with avartanam "1 0 U" and laghu_length 4

  @javascript
  Scenario: Should not create a talam with duplicate name
    Given I have a talam "Adi"
    And I have a signed as a normal user
    When I am on the new talam page
    And I fill in the following:
      | talam_name | Adi |
      | talam_avartanam | 1 0 U |
      | talam_laghu_length | 4 |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_name" field should have error "is already taken"

  @javascript
  Scenario: Should not create a talam with duplicate avartanam and laghu_length
    Given the following talams:
      | name | avartanam | laghu_length |
      | Adi | 1 0 U | 4 |
    And I have a signed as a normal user
    When I am on the new talam page
    And I fill in the following:
      | talam_name | Mohanam |
      | talam_avartanam | 1 0 U |
      | talam_laghu_length | 4 |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_laghu_length" field should have error "is already taken"

  @javascript
  Scenario: Should not create talam without name
    Given I am on the new talam page
    And I have a signed as a normal user
    And I fill in the following:
      | talam_avartanam | 1 0 U |
      | talam_laghu_length | 4 |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_name" field should have error "can't be blank"

  @javascript
  Scenario: Should not create talam without avartanam
    Given I am on the new talam page
    And I have a signed as a normal user
    And I fill in the following:
      | talam_name | Adi |
      | talam_laghu_length | 4 |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_avartanam" field should have error "can't be blank"

  @javascript
  Scenario: Should not create talam without laghu_length
    Given I am on the new talam page
    And I have a signed as a normal user
    And I fill in the following:
      | talam_name | Adi |
      | talam_avartanam | 1 0 U |
    And I press "Submit"
    Then I should be on the new talam page
    And I should see "Please review the highlighted fields"
    And "talam_laghu_length" field should have error "can't be blank"

  @javascript
  Scenario: Edit a talam
    Given the following talams:
      | name | avartanam | laghu_length |
      | Adi | 1 0 U | 4 |
      | Roopagam | 1 1 1 0 U  | 5 |
    And I have a signed as a normal user
    When I am on the talams_list page
    And I follow "edit" within "tbody > tr:nth-child(1)"
    Then the "talam_name" field should contain "Adi"
    And the "talam_avartanam" field should contain "1 0 U"
    And the "talam_laghu_length" field should contain "4"
    Then I fill in the following:
      | talam_name | New Adi |
      | talam_avartanam | 1 1 0 U |
      | talam_laghu_length | 6 |
    And I press "Submit"
    Then I should be on the talams_list page
    And the talam "New Adi" should be with avartanam "1 1 0 U" and laghu_length 6

  Scenario: Show a talam
    Given the following talams:
      | name | avartanam | laghu_length |
      | Adi | 1 0 U | 4 |
    And I am on the talams_list page
    When I follow "Adi"
    Then I should be on talam Adi's show page
    And I should see "Talam Adi"
    And I should see "Name"
    And I should see "Adi"
    And I should see "Avartanam"
    And I should see "1 0 U"
    And I should see "Laghu Length"
    And I should see "4"
