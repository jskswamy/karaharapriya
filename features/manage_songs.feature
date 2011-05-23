Feature: Manage songs
  In order to create, delete and update the song
  As a user
  I wants to add, update and delete the song

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
      | Dinesh |
    Then I should not see the following autocomplete options:
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
    Then I should not see the following autocomplete options:
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
      | song_content | ga ga ri sa sa ri ri |
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I select "Varnam" from "song_song_type"
    And I press "Submit"
    Then I should be on the songs_list page

  @javascript
  Scenario: Edit a song
    Given I have a song "Ninu kori" with content "sa re ga ma" song_type "Varnam" ragam "Mohanam" talam "Adi" by composer "Thyagarajar"
    And I have a song type "Geetham"
    And I have a composer "Muthuswamy"
    And I have a ragam "Sankarabharanam"
    And I have a talam "Rupagam"
    When I am on the songs_list page
    And I follow "Ninu kori"
    Then the "song_name" field should contain "Ninu kori"
    And the "song_content" field should contain "sa re ga ma"
    And the "song_composer" field should contain "Thyagarajar"
    And the "song_ragam" field should contain "Mohanam"
    And the "song_talam" field should contain "Adi"
    Then I fill in the following:
      | song_name | Shayamala meenakshi |
      | song_content | sa re ga ma pa pa |
    And I select "Geetham" from "song_song_type"
    And I choose "Muthuswamy" as "song_composer" using auto complete
    And I choose "Sankarabharanam" as "song_ragam" using auto complete
    And I choose "Rupagam" as "song_talam" using auto complete
    And I press "Submit"
    Then I should be on the songs_list page
    And I should see "Shayamala meenakshi"
