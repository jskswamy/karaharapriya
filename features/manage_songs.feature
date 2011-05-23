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
    Then I should not see the following autocomplete options:
      | Bobby |
      | Dinesh |

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
