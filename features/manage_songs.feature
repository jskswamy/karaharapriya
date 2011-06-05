Feature: Manage songs
  In order to create, delete and update the song
  As a user
  I want to add, update and delete the song

  @javascript
  Scenario: Composer auto suggestion
    Given I have following composers:
      | Ashwin |
      | Bobby |
      | Chandru |
      | Dinesh |
    When I am on the new song page
    And I fill in "song_composer" with "A"
    Then I should see the following autocomplete options:
      | Ashwin |
      | Chandru |
    And I should not see the following autocomplete options:
      | Bobby |
      | Dinesh |
    When I click on the "Chandru" autocomplete option
    Then the "song_composer" field should contain "Chandru"

  @javascript
  Scenario: Ragam auto suggestion
    Given I have following ragams:
      | Mohanam |
      | Keeravani |
      | Shulini  |
      | Dinesh |
    When I am on the new song page
    And I fill in "song_ragam" with "A"
    Then I should see the following autocomplete options:
      | Mohanam |
      | Keeravani |
    And I should not see the following autocomplete options:
      | Dinesh |
      | Shulini  |
    When I click on the "Keeravani" autocomplete option
    Then the "song_ragam" field should contain "Keeravani"

  @javascript
  Scenario: Talam auto suggestion
    Given I have following talams:
      | Adi |
      | Roopagam |
      | Tisr  |
    When I am on the new song page
    And I fill in "song_talam" with "A"
    Then I should see the following autocomplete options:
      | Adi |
      | Roopagam |
    And I should not see the following autocomplete options:
      | Tisr  |
    When I click on the "Adi" autocomplete option
    Then the "song_talam" field should contain "Adi"

  @javascript
  Scenario: Create new song
    Given I have a song type "Varnam"
    And I have a composer "Thyagarajar"
    And I have a ragam "Mohanam"
    And I have a talam "Adi"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
      | song_description | Awesome mohanam varnam |
    And I select "Varnam" from "song_song_type"
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I press "Submit"
    Then I should be on the songs_list page
    And I should see "Ninu kori"
    And the song "Ninu kori" should be with content "ga ga ri sa sa ri ri", song_type "Varnam", ragam "Mohanam", talam "Adi", description "Awesome mohanam varnam" and by composer "Thyagarajar"

  @javascript
  Scenario: Should create a song without description and composer
    Given I have a song type "Varnam"
    And I have a composer "Thyagarajar"
    And I have a ragam "Mohanam"
    And I have a talam "Adi"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
    And I select "Varnam" from "song_song_type"
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I press "Submit"
    Then I should be on the songs_list page
    And I should see "Ninu kori"
    And the song "Ninu kori" should be with content "ga ga ri sa sa ri ri", song_type "Varnam", ragam "Mohanam", talam "Adi", description "" and by composer ""

  @javascript
  Scenario: Should not create a song if the name is already taken
    Given I have a song "Ninu kori" with content "sa re ga ma", song_type "Varnam", ragam "Mohanam", talam "Adi" and by composer "Thyagarajar"
    And I have a song type "Geetham"
    And I have a composer "Pattamal"
    And I have a ragam "Gowlai"
    And I have a talam "Roopagam"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
      | song_description | Awesome mohanam varnam |
    And I select "Geetham" from "song_song_type"
    And I choose "Pattamal" as "song_composer" using auto complete
    And I choose "Gowlai" as "song_ragam" using auto complete
    And I choose "Roopagam" as "song_talam" using auto complete
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I press "Submit"
    Then I should be on the new song page
    And I should see "Please review the highlighted fields"
    And "song_name" field should have error "is already taken"

  @javascript
  Scenario: Should create a song if the error are satisfied
    Given I have a song "Ninu kori" with content "sa re ga ma", song_type "Varnam", ragam "Mohanam", talam "Adi" and by composer "Thyagarajar"
    And I have a song type "Geetham"
    And I have a composer "Pattamal"
    And I have a ragam "Gowlai"
    And I have a talam "Roopagam"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
      | song_description | Awesome geetham |
    And I select "Geetham" from "song_song_type"
    And I choose "Pattamal" as "song_composer" using auto complete
    And I choose "Gowlai" as "song_ragam" using auto complete
    And I choose "Roopagam" as "song_talam" using auto complete
    And I fill in "song_content" wysiwyg editor with "sa ni th pa pa"
    And I press "Submit"
    And "song_name" field should have error "is already taken"
    Then I fill in "song_name" with "Ganapathy"
    And I press "Submit"
    Then I should be on the songs_list page
    And I should see "Ganapathy"
    And the song "Ganapathy" should be with content "sa ni th pa pa", song_type "Geetham", ragam "Gowlai", talam "Roopagam", description "Awesome geetham" and by composer "Pattamal"

  @javascript
  Scenario: Should not create a song without name
    Given I have a song type "Varnam"
    And I have a composer "Thyagarajar"
    And I have a ragam "Mohanam"
    And I have a talam "Adi"
    When I am on the new song page
    And I fill in the following:
      | song_description | Awesome mohanam varnam |
    And I select "Varnam" from "song_song_type"
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I press "Submit"
    Then I should be on the new song page
    And I should see "Please review the highlighted fields"
    And "song_name" field should have error "can't be blank"

  @javascript
  Scenario: Should not create a song without song_type
    Given I have a song type "Varnam"
    And I have a composer "Thyagarajar"
    And I have a ragam "Mohanam"
    And I have a talam "Adi"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
      | song_description | Awesome mohanam varnam |
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I press "Submit"
    Then I should be on the new song page
    And I should see "Please review the highlighted fields"
    And "song_song_type" field should have error "can't be blank"

  @javascript
  Scenario: Should not create a song without ragam
    Given I have a song type "Varnam"
    And I have a composer "Thyagarajar"
    And I have a ragam "Mohanam"
    And I have a talam "Adi"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
      | song_description | Awesome mohanam varnam |
    And I select "Varnam" from "song_song_type"
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I press "Submit"
    Then I should be on the new song page
    And I should see "Please review the highlighted fields"
    And "song_ragam" field should have error "can't be blank"

  @javascript
  Scenario: Should not create a song without talam
    Given I have a song type "Varnam"
    And I have a composer "Thyagarajar"
    And I have a ragam "Mohanam"
    And I have a talam "Adi"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
      | song_description | Awesome mohanam varnam |
    And I select "Varnam" from "song_song_type"
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I press "Submit"
    Then I should be on the new song page
    And I should see "Please review the highlighted fields"
    And "song_talam" field should have error "can't be blank"

  @javascript
  Scenario: Should not create a song without content
    Given I have a song type "Varnam"
    And I have a composer "Thyagarajar"
    And I have a ragam "Mohanam"
    And I have a talam "Adi"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
      | song_description | Awesome mohanam varnam |
    And I select "Varnam" from "song_song_type"
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I press "Submit"
    Then I should be on the new song page
    And I should see "Please review the highlighted fields"

  @javascript
  Scenario: Edit a song
    Given I have a song "Ninu kori" with content "sa re ga ma", song_type "Varnam", ragam "Mohanam", talam "Adi" and by composer "Thyagarajar"
    And I have a song type "Geetham"
    And I have a composer "Muthuswamy"
    And I have a ragam "Sankarabharanam"
    And I have a talam "Rupagam"
    When I am on the songs_list page
    And I follow "Ninu kori"
    Then the "song_name" field should contain "Ninu kori"
    And the "song_composer" field should contain "Thyagarajar"
    And the "song_ragam" field should contain "Mohanam"
    And the "song_talam" field should contain "Adi"
    And the "song_content" wysiwyg editor should contain "sa re ga ma"
    And "Varnam" should be selected for "song_song_type"
    Then I fill in the following:
      | song_name | Shayamala meenakshi |
      | song_description | Master piece |
    And I select "Geetham" from "song_song_type"
    And I choose "Muthuswamy" as "song_composer" using auto complete
    And I choose "Sankarabharanam" as "song_ragam" using auto complete
    And I choose "Rupagam" as "song_talam" using auto complete
    And I fill in "song_content" wysiwyg editor with "sa re ga ma pa pa"
    And I press "Submit"
    Then I should be on the songs_list page
    And I should see "Shayamala meenakshi"
    And the song "Shayamala meenakshi" should be with content "sa re ga ma pa pa", song_type "Geetham", ragam "Sankarabharanam", talam "Rupagam", description "Master piece" and by composer "Muthuswamy"
