# QA assignment - funda.nl
This project contains solution for Funda QA Assignment

## Technology stack
* Ruby
* Capybara
* Cucumber
* Selenium

## Configuration
You can edit "support/env.rb" file to configure test suite.
There are three variables that you can edit and change the test environment
* ENVIRONMENT: Determines browser
    * "LOCAL_CHROME": tests run on chrome browser
    * "HEADLESS_CHROME": tests run on headless chrome browser
* OS: You should select your operating system
    * "MACOS"
    * "LINUX"
    * "WINDOWS"
* SIZE: Determines the browser window width
    * "1200": wide design for funda.nl
    * "800": mid size design for funda.nl
    * "400" narrow design for funda.nl

You can edit test steps to run tests on LIVE or QA environment:
To run test on LIVE environment:
```
    Given I am at homepage as "guest" on "LIVE" environment
```
To run test on QA environment:
```
    Given I am at homepage as "guest" on "QA" environment
```

## Scenarios
* #### Search
    * Is Koop default tab on search component
* #### Search Component - Huur Tab Tests
    * Click to clear (X) button to delete input on address textbox
    * Check defaults for huur tab
    * Select a max price, lower than selected min price
    * Make a search on Huur tab - use all criterias
    * Make a search on Huur tab - use min and max price criterias
    * Make a search on Huur tab - just use address criteria
    * Make a search on Huur tab - just use random distance criteria
    * Make a search on Huur tab - just use min price criteria
    * Make a search on Huur tab - just use max price criteria
    * Save and show last searched criterias on the search component - use all criterias
    * Save and show last searched criterias on the search component - use min and max price criterias
    * Save and show last searched criterias on the search component - just use address criteria
    * Save and show last searched criterias on the search component - just use distance criteria
    * Save and show last searched criterias on the search component - just use min price criteria
    * Save and show last searched criterias on the search component - just use max price criteria
    * Select an address via autocomplete and make a search on Huur tab
    * Make a search on Huur tab - Use "Anders" min and max prices
* ##### Search Component - Koop Tab Tests
    * Click to clear (X) button to delete input on address textbox
    * Check defaults for Koop tab
    * Select a max price, lower than selected min price
    * Make a search on Koop tab - use all criterias
    * Make a search on Koop tab - use min and max price criterias
    * Make a search on Koop tab - just use address criteria
    * Make a search on Koop tab - just use random distance criteria
    * Make a search on Koop tab - just use min price criteria
    * Make a search on Koop tab - just use max price criteria
    * Save and show last searched criterias on the search component - use all criterias
    * Save and show last searched criterias on the search component - use min and max price criterias
    * Save and show last searched criterias on the search component - just use address criteria
    * Save and show last searched criterias on the search component - just use distance criteria
    * Save and show last searched criterias on the search component - just use min price criteria
    * Save and show last searched criterias on the search component - just use max price criteria
    * Select an address via autocomplete and make a search on Koop tab
    * Make a search on Koop tab - Use "Anders" min and max prices

## Reports
You can find test reports at: "/testResults/reports/Results.html"

## Notes
This project is developed and tested on macOS with chrome browser and 1200px width.
Due to limitted time, Code is not tested for different browsers and sizes. There should be a need for a few more fixes for different sizes and browsers. 