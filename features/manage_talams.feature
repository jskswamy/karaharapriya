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

  @wip
  Scenario: Should not create a ragam with duplicate name
    Given I have a ragam "Mohanam"
    When I am on the new ragam page
    And I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
      | ragam_description | Beautiful ragam |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_name" field should have error "is already taken"

  @wip
  Scenario: Should not create a ragam with duplicate arohana and avarohana
    Given the following ragams:
      | name | arohana | avarohana |
      | Kalyani | sa ri ga pa th sa | sa th pa ga ri sa |
    When I am on the new ragam page
    And I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
      | ragam_description | Beautiful ragam |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_arohana" field should have error "and Avarohana already defined for another ragam"

  @wip
  Scenario: Should not create a ragam without name
    Given I am on the new ragam page
    When I fill in the following:
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
      | ragam_description | Beautiful ragam |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_name" field should have error "can't be blank"

  @wip
  Scenario: Should not create a ragam without arohana
    Given I am on the new ragam page
    When I fill in the following:
      | ragam_name | Mohanam |
      | ragam_avarohana | sa th pa ga ri sa |
      | ragam_description | Beautiful ragam |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_arohana" field should have error "can't be blank"

  @wip
  Scenario: Should not create a ragam without avarohana
    Given I am on the new ragam page
    When I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_description | Beautiful ragam |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_avarohana" field should have error "can't be blank"

  @wip
  Scenario: Should not create a ragam without description
    Given I am on the new ragam page
    When I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_description" field should have error "can't be blank"

  @wip
  Scenario: Edit a ragam
    Given I have a ragam "Beemplas" with arohana "sa re ga ma pa th ni sa", avarohana "sa ni th pa ma ga ri sa", parent ragam "" and description "Mohanam"
    Given I have a ragam "Sankarabharanam"
    When I am on the ragams_list page
    And I follow "Beemplas"
    Then I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa re ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
      | ragam_description | Renamed to mohanam |
    And I choose "Sankarabharanam" as "ragam_parent" using auto complete
    And I press "Submit"
    Then the ragam "Mohanam" should be with arohana "sa re ga pa th sa", avarohana "sa th pa ga ri sa", parent ragam "Sankarabharanam" and description "Renamed to mohanam"
