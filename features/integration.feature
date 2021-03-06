Feature: Integration Tests
  In order to create, delete and update the song, ragam, composer and talam
  As a user
  I wants to ability to create ragam, talam, composer and song and should be able integrate it.

  @javascript
  Scenario: Should display the newly ragam created in auto suggestion
    Given I have following ragams:
      | Mohanam |
      | Keeravani |
      | Shulini |
    And I have a signed as a normal user
    When I am on the new song page
    And I fill in "song_ragam" with "A"
    Then I should not see the following autocomplete options:
      | Sankarabharanam |
    Then I am on the new ragam page
    And I fill in the following:
      | ragam_name | Sankarabharanam |
      | ragam_arohana | sa re ga pa th sa |
      | ragam_avarohana | sa th pa ga re sa |
    And I press "Submit"
    Then I am on the new song page
    And I fill in "song_ragam" with "A"
    Then I should see the following autocomplete options:
      | Mohanam |
      | Keeravani |
      | Sankarabharanam |
    When I click on the "Sankarabharanam" autocomplete option
    Then the "song_ragam" field should contain "Sankarabharanam"

  @javascript
  Scenario: Should display the updated ragam name in auto suggestion
    Given I have following ragams:
      | Mohnm |
      | Keeravani |
      | Sankarabharanam |
    And I have a signed as a normal user
    When I am on the new song page
    And I fill in "song_ragam" with "A"
    Then I should see the following autocomplete options:
      | Keeravani |
      | Sankarabharanam |
    Then I should not see the following autocomplete options:
      | Mohnm |
    When I am on the ragams_list page
    And I follow "edit" within "tbody > tr:nth-child(1)"
    And I fill in the following:
      | ragam_name | Mohanam |
    And I press "Submit"
    When I am on the new song page
    And I fill in "song_ragam" with "moh"
    Then I should see the following autocomplete options:
      | Mohanam |
    Then I should not see the following autocomplete options:
      | Mohnm |
    When I click on the "Mohanam" autocomplete option
    Then the "song_ragam" field should contain "Mohanam"

  @javascript
  Scenario: Should display the newly create talam in auto suggestion
    Given the following talams:
      | name | avartanam | laghu_length |
      | Adi | 1 0 U | 4 |
      | Roopagam | 1 1 1 0 U  | 5 |
    And I have a signed as a normal user
    When I am on the new song page
    And I fill in "song_talam" with "A"
    Then I should not see the following autocomplete options:
      | Tisra |
    Then I am on the new talam page
    And I fill in the following:
      | talam_name | Tisra |
      | talam_avartanam | 1 0 U U U |
      | talam_laghu_length | 2 |
    And I press "Submit"
    Then I am on the new song page
    And I fill in "song_talam" with "A"
    Then I should see the following autocomplete options:
      | Adi |
      | Roopagam |
      | Tisra |
    When I click on the "Tisra" autocomplete option
    Then the "song_talam" field should contain "Tisra"

  @javascript
  Scenario: Should display the updated talam name in auto suggestion
    Given the following talams:
      | name | avartanam | laghu_length |
      | dai | 1 0 U | 4 |
      | Roopagam | 1 1 1 0 U  | 5 |
    And I have a signed as a normal user
    When I am on the new song page
    And I fill in "song_talam" with "A"
    Then I should see the following autocomplete options:
      | dai |
      | Roopagam |
    When I am on the talams_list page
    And I follow "edit" within "tbody > tr:nth-child(1)"
    And I fill in the following:
      | talam_name | Tisra |
    And I press "Submit"
    When I am on the new song page
    And I fill in "song_talam" with "a"
    Then I should see the following autocomplete options:
      | Tisra |
      | Roopagam |
    Then I should not see the following autocomplete options:
      | dai |
    When I click on the "Tisra" autocomplete option
    Then the "song_talam" field should contain "Tisra"

  @javascript
  Scenario: Should display the newly create composer in auto suggestion
    Given the following composers:
      | name | century |
      | Thyagarajar | 19th |
      | Boominathar | 20th  |
    And I have a signed as a normal user
    When I am on the new song page
    And I fill in "song_composer" with "A"
    Then I should not see the following autocomplete options:
      | Muthuswamy |
    Then I am on the new composer page
    And I fill in the following:
      | composer_name | Muthuswamy |
      | composer_century | 21st |
    And I press "Submit"
    Then I am on the new song page
    And I fill in "song_composer" with "A"
    Then I should see the following autocomplete options:
      | Thyagarajar |
      | Boominathar |
      | Muthuswamy |
    When I click on the "Muthuswamy" autocomplete option
    Then the "song_composer" field should contain "Muthuswamy"

  @javascript
  Scenario: Should display the updated composer name in auto suggestion
    Given the following composers:
      | name | century |
      | Thyagarajar | 19th |
      | Boominathar | 20th  |
    And I have a signed as a normal user
    When I am on the new song page
    And I fill in "song_composer" with "A"
    Then I should see the following autocomplete options:
      | Thyagarajar |
      | Boominathar |
    When I am on the composers_list page
    And I follow "edit" within "tbody > tr:nth-child(1)"
    And I fill in the following:
      | composer_name | Muthuswamy |
    And I press "Submit"
    When I am on the new song page
    And I fill in "song_composer" with "a"
    Then I should see the following autocomplete options:
      | Muthuswamy |
      | Boominathar |
    Then I should not see the following autocomplete options:
      | Thyagarajar |
    When I click on the "Muthuswamy" autocomplete option
    Then the "song_composer" field should contain "Muthuswamy"

  @javascript
  Scenario: Should display the updated ragam name for existing song
    Given I have a song "Ninu kori" with content "sa re ga ma", song_type "Varnam", ragam "Mohnm", talam "Adi" and by composer "Thyagarajar"
    And I have a signed as a normal user
    When I am on the ragams_list page
    And I follow "edit"
    And I fill in the following:
      |ragam_name | Mohanam |
    And I press "Submit"
    Then I am on the songs_list page
    And I follow "edit"
    And the "song_ragam" field should contain "Mohanam"

  @javascript
  Scenario: Should be able to use the newly created ragam for creating a song
    Given I have a song type "Varnam"
    And I have a composer "Thyagarajar"
    And I have a talam "Adi"
    And I have a signed as a normal user
    When I am on the new ragam page
    And I fill in the following:
      |ragam_name | Mohanam |
      | ragam_arohana | sa re ga pa th sa |
      | ragam_avarohana | sa th pa ga re sa |
    And I press "Submit"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I select "Varnam" from "song_song_type"
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I press "Submit"
    Then I should be on the songs_list page
    And I should see "Ninu kori"
    And the song "Ninu kori" should be with content "ga ga ri sa sa ri ri", song_type "Varnam", ragam "Mohanam", talam "Adi" and by composer "Thyagarajar"

  @javascript
  Scenario: Should be able to use the newly created talam for creating a song
    Given I have a song type "Varnam"
    And I have a composer "Thyagarajar"
    And I have a ragam "Mohanam"
    And I have a signed as a normal user
    When I am on the new talam page
    And I fill in the following:
      | talam_name | Adi |
      | talam_avartanam | 1 1 1 0 U |
      | talam_laghu_length | 6 |
    And I press "Submit"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I select "Varnam" from "song_song_type"
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I press "Submit"
    Then I should be on the songs_list page
    And I should see "Ninu kori"
    And the song "Ninu kori" should be with content "ga ga ri sa sa ri ri", song_type "Varnam", ragam "Mohanam", talam "Adi" and by composer "Thyagarajar"

  @javascript
  Scenario: Should be able to use the newly created composer for creating a song
    Given I have a song type "Varnam"
    And I have a talam "Adi"
    And I have a ragam "Mohanam"
    And I have a signed as a normal user
    When I am on the new composer page
    And I fill in the following:
      | composer_name | Thyagarajar |
      | composer_century | 18th |
    And I press "Submit"
    When I am on the new song page
    And I fill in the following:
      | song_name | Ninu kori |
    And I fill in "song_content" wysiwyg editor with "ga ga ri sa sa ri ri"
    And I select "Varnam" from "song_song_type"
    And I choose "Thyagarajar" as "song_composer" using auto complete
    And I choose "Mohanam" as "song_ragam" using auto complete
    And I choose "Adi" as "song_talam" using auto complete
    And I press "Submit"
    Then I should be on the songs_list page
    And I should see "Ninu kori"
    And the song "Ninu kori" should be with content "ga ga ri sa sa ri ri", song_type "Varnam", ragam "Mohanam", talam "Adi" and by composer "Thyagarajar"
