Feature: Search Component - Koop Tab Tests

  Background:
    Given I am at homepage as "guest" on "LIVE" environment
    When I click to "Koop" tab

  Scenario: Click to clear (X) button to delete input on address textbox
    And I write "Diemen" on address textbox
    And I click to clear (X) button
    Then I should not see any input on the address textbox

  Scenario: Check defaults for koop tab
    Then I should see default texts and selections on search component

  Scenario: Select a max price, lower than selected min price
    And I select a random min price
    And I select a random max price lower than selected min price
    Then I should see max price font color as red

  Scenario: Make a search on Koop tab - use all criterias
    And I write "Diemen" on address textbox
    And I select a random distance
    And I select a random min price
    And I select a random max price higher than selected min price
    And I click to Zoek button
    Then I should be at "koop" listing page
    And I should see correct values on filters

  Scenario: Make a search on Koop tab - use min and max price criterias
    And I select a random min price
    And I select a random max price higher than selected min price
    And I click to Zoek button
    Then I should be at "koop" listing page
    And I should see correct values on filters

  Scenario: Make a search on Koop tab - just use address criteria
    And I write "Diemen" on address textbox
    And I click to Zoek button
    Then I should be at "koop" listing page
    And I should see correct values on filters

  Scenario: Make a search on Koop tab - just use random distance criteria
    And I select a random distance
    And I click to Zoek button
    Then I should be at "koop" listing page
    And I should see correct values on filters

  Scenario: Make a search on Koop tab - just use min price criteria
    And I select a random min price
    And I click to Zoek button
    Then I should be at "koop" listing page
    And I should see correct values on filters

  Scenario: Make a search on Koop tab - just use max price criteria
    And I select a random max price
    And I click to Zoek button
    Then I should be at "koop" listing page
    And I should see correct values on filters

  Scenario: Save and show last searched criterias on the search component - use all criterias
    And I write "Diemen" on address textbox
    And I select a random distance
    And I select a random min price
    And I select a random max price higher than selected min price
    And I click to Zoek button
    And I should be at "koop" listing page
    And I go to home page via Funda Logo
    Then I should see my last search on the quick search component
    And I click to my last search
    And I should see correct values on filters


  Scenario: Save and show last searched criterias on the search component - use min and max price criterias
    And I select a random min price
    And I select a random max price higher than selected min price
    And I click to Zoek button
    And I should be at "koop" listing page
    And I go to home page via Funda Logo
    Then I should see my last search on the quick search component
    And I click to my last search
    And I should see correct values on filters

  Scenario: Save and show last searched criterias on the search component - just use address criteria
    And I write "Diemen" on address textbox
    And I click to Zoek button
    And I should be at "koop" listing page
    And I go to home page via Funda Logo
    Then I should see my last search on the quick search component
    And I click to my last search
    And I should see correct values on filters

  Scenario: Save and show last searched criterias on the search component - just use distance criteria
    And I select a random distance
    And I click to Zoek button
    And I should be at "koop" listing page
    And I go to home page via Funda Logo
    Then I should see my last search on the quick search component
    And I click to my last search
    And I should see correct values on filters

  Scenario: Save and show last searched criterias on the search component - just use min price criteria
    And I select a random min price
    And I click to Zoek button
    And I should be at "koop" listing page
    And I go to home page via Funda Logo
    Then I should see my last search on the quick search component
    And I click to my last search
    And I should see correct values on filters

  Scenario: Save and show last searched criterias on the search component - just use max price criteria
    And I select a random max price
    And I click to Zoek button
    And I should be at "koop" listing page
    And I go to home page via Funda Logo
    Then I should see my last search on the quick search component
    And I click to my last search
    And I should see correct values on filters

  Scenario: Select an address via autocomplete and make a search on Koop tab
    And I write "Amsterdam" on address textbox
    And I should see related addresses on autocomplete dropdown
    And I select an address from autocomplete dropdown
    And I click to Zoek button
    Then I should be at "koop" listing page
    And I should see correct values on filters

  Scenario: Make a search on Koop tab - Use "Anders" min and max prices
    And I set min price as "123123"
    And I set max price as "234234"
    And I click to Zoek button
    Then I should be at "koop" listing page
    And I should see correct values on filters