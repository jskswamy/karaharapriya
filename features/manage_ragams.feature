Feature: Manage ragams
  In order to create, delete and update the ragams
  As a user
  I want to add, update and delete the ragam

  @javascript
  Scenario: Parent ragam auto suggestion
    Given I have following ragams:
      | Mohanam |
      | Sankarabharanam |
      | Gowli |
      | Kalyani |
    When I am on the new ragam page
    And I fill in "ragam_parent" with "A"
    Then I should see the following autocomplete options:
      | Mohanam |
      | Sankarabharanam |
      | Kalyani |
    And I should not see the following autocomplete options:
      | Gowli |
    When I click on the "Kalyani" autocomplete option
    Then the "ragam_parent" field should contain "Kalyani"

  @javascript
  Scenario: Create new ragam
    Given I have a ragam "Sankarabharanam"
    When I am on the new ragam page
    And I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa re ga pa th sa |
      | ragam_avarohana | sa th pa ga re sa |
    And I fill in "ragam_description" wysiwyg editor with "Beautiful ragam"
    And I choose "Sankarabharanam" as "ragam_parent" using auto complete
    And I press "Submit"
    Then I should be on the ragams_list page
    And the ragam "Mohanam" should be with arohana "sa re ga pa th sa", avarohana "sa th pa ga re sa", parent ragam "Sankarabharanam" and description "Beautiful ragam"

  @javascript
  Scenario: Should not create a ragam with duplicate name
    Given I have a ragam "Mohanam"
    When I am on the new ragam page
    And I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I fill in "ragam_description" wysiwyg editor with "Beautiful ragam"
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_name" field should have error "is already taken"

  @javascript
  Scenario: Should not create a ragam with duplicate arohana and avarohana
    Given the following ragams:
      | name | arohana | avarohana |
      | Kalyani | sa ri ga pa th sa | sa th pa ga ri sa |
    When I am on the new ragam page
    And I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I fill in "ragam_description" wysiwyg editor with "Beautiful ragam"
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_arohana" field should have error "is already taken"

  @javascript
  Scenario: Should not create a ragam without name
    Given I am on the new ragam page
    When I fill in the following:
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I fill in "ragam_description" wysiwyg editor with "Beautiful ragam"
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_name" field should have error "can't be blank"

  @javascript
  Scenario: Should not create a ragam without arohana
    Given I am on the new ragam page
    When I fill in the following:
      | ragam_name | Mohanam |
      | ragam_avarohana | sa th pa ga ri sa |
    And I fill in "ragam_description" wysiwyg editor with "Beautiful ragam"
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_arohana" field should have error "can't be blank"

  @javascript
  Scenario: Should not create a ragam without avarohana
    Given I am on the new ragam page
    When I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
    And I fill in "ragam_description" wysiwyg editor with "Beautiful ragam"
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_avarohana" field should have error "can't be blank"

  @javascript
  Scenario: Should not create a ragam without description
    Given I am on the new ragam page
    When I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"

  @javascript
  Scenario: Edit a ragam
    Given I have a ragam "Beemplas" with arohana "sa re ga ma pa th ni sa", avarohana "sa ni th pa ma ga ri sa", parent ragam "" and description "Mohanam"
    Given I have a ragam "Sankarabharanam"
    When I am on the ragams_list page
    And I follow "Beemplas"
    Then the "ragam_name" field should contain "Beemplas"
    And the "ragam_arohana" field should contain "sa re ga ma pa th ni sa"
    And the "ragam_avarohana" field should contain "sa ni th pa ma ga ri sa"
    And the "ragam_description" wysiwyg editor should contain "Mohanam"
    Then I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa re ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I fill in "ragam_description" wysiwyg editor with "Renamed to mohanam"
    And I choose "Sankarabharanam" as "ragam_parent" using auto complete
    And I fill in "ragam_description" wysiwyg editor with "Renamed to mohanam"
    And I press "Submit"
    Then the ragam "Mohanam" should be with arohana "sa re ga pa th sa", avarohana "sa th pa ga ri sa", parent ragam "Sankarabharanam" and description "Renamed to mohanam"
