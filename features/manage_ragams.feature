Feature: Manage ragams
  In order to create, delete and update the ragams
  As a user
  I want to add, update and delete the ragam

  @javascript
  Scenario: Should not be allowed to create ragam without sign in
    When I am on the new ragam page
    Then I should be on the sign_in page

  @javascript
  Scenario: Should not be allowed to edit the ragam without sign in
    Given I have a ragam "Beemplas" with arohana "sa re ga ma pa th ni sa", avarohana "sa ni th pa ma ga ri sa" and parent ragam ""
    When I am on the ragams_list page
    And I follow "edit" within "tbody > tr:nth-child(1)"
    Then I should be on the sign_in page

  @javascript
  Scenario: Parent ragam auto suggestion
    Given I have following ragams:
      | Mohanam |
      | Sankarabharanam |
      | Gowli |
      | Kalyani |
    And I have a signed as a normal user
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
    And I have a signed as a normal user
    When I am on the new ragam page
    And I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa re ga pa th sa |
      | ragam_avarohana | sa th pa ga re sa |
    And I choose "Sankarabharanam" as "ragam_parent" using auto complete
    And I press "Submit"
    Then I should be on the ragams_list page
    And the ragam "Mohanam" should be with arohana "sa re ga pa th sa", avarohana "sa th pa ga re sa" and parent ragam "Sankarabharanam"

  @javascript
  Scenario: Should not create a ragam with duplicate name
    Given I have a ragam "Mohanam"
    And I have a signed as a normal user
    When I am on the new ragam page
    And I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_name" field should have error "is already taken"

  @javascript
  Scenario: Should not create a ragam with duplicate arohana and avarohana
    Given the following ragams:
      | name | arohana | avarohana |
      | Kalyani | sa ri ga pa th sa | sa th pa ga ri sa |
    And I have a signed as a normal user
    When I am on the new ragam page
    And I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_arohana" field should have error "is already taken"

  @javascript
  Scenario: Should not create a ragam without name
    Given I am on the new ragam page
    And I have a signed as a normal user
    When I fill in the following:
      | ragam_arohana | sa ri ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_name" field should have error "can't be blank"

  @javascript
  Scenario: Should not create a ragam without arohana
    Given I am on the new ragam page
    And I have a signed as a normal user
    When I fill in the following:
      | ragam_name | Mohanam |
      | ragam_avarohana | sa th pa ga ri sa |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_arohana" field should have error "can't be blank"

  @javascript
  Scenario: Should not create a ragam without avarohana
    Given I am on the new ragam page
    And I have a signed as a normal user
    When I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa ri ga pa th sa |
    And I press "Submit"
    Then I should be on the new ragam page
    And I should see "Please review the highlighted fields"
    And "ragam_avarohana" field should have error "can't be blank"

  @javascript
  Scenario: Edit a ragam
    Given I have a ragam "Sankarabharanam" with arohana "sa re ga ma pa th ni sa", avarohana "sa ni th ga ri sa" and parent ragam ""
    And I have a ragam "Beemplas" with arohana "sa re ga ma pa th ni sa", avarohana "sa ni th pa ma ga ri sa" and parent ragam ""
    And I have a signed as a normal user
    When I am on the ragams_list page
    And I follow "edit" within "tbody > tr:nth-child(2)"
    Then the "ragam_name" field should contain "Beemplas"
    And the "ragam_arohana" field should contain "sa re ga ma pa th ni sa"
    And the "ragam_avarohana" field should contain "sa ni th pa ma ga ri sa"
    Then I fill in the following:
      | ragam_name | Mohanam |
      | ragam_arohana | sa re ga pa th sa |
      | ragam_avarohana | sa th pa ga ri sa |
    And I choose "Sankarabharanam" as "ragam_parent" using auto complete
    And I press "Submit"
    Then the ragam "Mohanam" should be with arohana "sa re ga pa th sa", avarohana "sa th pa ga ri sa" and parent ragam "Sankarabharanam"

  Scenario: Show a ragam
    Given I have a ragam "Sankarabharanam" with arohana "sa re ga ma pa th ni sa", avarohana "sa ni th pa ma ga ri sa" and parent ragam ""
    And I have a ragam "Mohanam" with arohana "sa re ga pa th sa", avarohana "sa th pa ga ri sa" and parent ragam "Sankarabharanam"
    And I am on the ragams_list page
    When I follow "Mohanam"
    Then I should be on ragam Mohanam's show page
    And I should see "Ragam Mohanam"
    And I should see "Name"
    And I should see "Mohanam"
    And I should see "Arohana"
    And I should see "sa re ga pa th sa"
    And I should see "Avarohana"
    And I should see "sa th pa ga ri sa"
    And I should see "Parent"
    And I should see "Sankarabharanam"
