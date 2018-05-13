When(/^I click to "([^"]*)" tab$/) do |tabName|
  if tabName == "Koop"
    findAndClickToElement("xpath", $searchSectionKoopTabButtonXpath)
    $activeTab = tabName
  elsif tabName == "Huur"
    findAndClickToElement("xpath", $searchSectionHuurTabButtonXpath)
    $activeTab = tabName
  elsif tabName == "Nieuwbouw"
    findAndClickToElement("xpath", $searchSectionNieuwbouwTabButtonXpath)
    $activeTab = tabName
  elsif tabName == "Recreatie"
    findAndClickToElement("xpath", $searchSectionRecreatieTabButtonXpath)
    $activeTab = tabName
  elsif tabName == "Europa"
    findAndClickToElement("xpath", $searchSectionEuropaTabButtonXpath)
    $activeTab = tabName
  end
  sleepLikeABaby 3
end

Then(/^I should see default texts and selections on search component$/) do
  addressTextbox = findElement("xpath", $searchSectionAddressTextboxXpath)
  addressTextboxDefaultText = addressTextbox['placeholder']
  expect(addressTextboxDefaultText).to eq($addressTextBoxPlaceHolder)

  defaultMaxPrice = find(:xpath, $searchSectionMaxPriceDropdownXpath).find('option[selected]').text
  expect(defaultMaxPrice).to eq($searchSectionMaxPriceDefault)


  defaultMinPrice = find(:xpath, $searchSectionMinPriceDropdownXpath).find('option[selected]').text
  expect(defaultMinPrice).to eq($searchSectionMinPriceDefault)

  activeTab = findElement("xpath", $searchSectionActiveTabXpath).text

  if activeTab == "Huur"
    defaultQuickSearchText = findElement("xpath", $searchSectionQuickSearchFullTextXpath).text
    puts defaultQuickSearchText
    expect(defaultQuickSearchText).to eq($searchSectionHuurTabQuickSearchDefaultText)
  elsif activeTab == "Nieuwbouw"
    defaultQuickSearchText = findElement("xpath", $searchSectionQuickSearchFullTextXpath)
    puts defaultQuickSearchText
  end


end

And(/^I write "([^"]*)" on address textbox$/) do |address|
  findElement("xpath", $searchSectionAddressTextboxXpath).set address
  sleep 1
  #Autocomplete does not work as fast as .set function that is why I send a space key to avoid flaky tests:
  findElement("xpath", $searchSectionAddressTextboxXpath).send_keys :space
  $searchedAddress = address
  sleepLikeABaby 1
end

And(/^I select a random distance$/) do
  selectDistanceIndex = rand(0..5)
  find(:xpath, $searchSectionDistanceDropdownXpath).all('option')[selectDistanceIndex].select_option
  $selectedDistanceValue = find(:xpath, $searchSectionDistanceDropdownXpath).all('option')[selectDistanceIndex].text
end

And(/^I select a random min price$/) do
  if $activeTab == "Koop"
    $selectMinPriceIndex = rand(1..29)
  elsif $activeTab == "Huur"
  $selectMinPriceIndex = rand(1..19)
  end
  find(:xpath, $searchSectionMinPriceDropdownXpath).all('option')[$selectMinPriceIndex].select_option
  $selectedMinPriceValue = find(:xpath, $searchSectionMinPriceDropdownXpath).all('option')[$selectMinPriceIndex].text
end

And(/^I select a random max price higher than selected min price$/) do
  if $activeTab == "Koop"
    $selectMaxPriceIndex = rand($selectMinPriceIndex..29)
  elsif $activeTab == "Huur"
    $selectMaxPriceIndex = rand($selectMinPriceIndex..19)
  end

  find(:xpath, $searchSectionMaxPriceDropdownXpath).all('option')[$selectMaxPriceIndex].select_option
  $selectedMaxPriceValue = find(:xpath, $searchSectionMaxPriceDropdownXpath).all('option')[$selectMaxPriceIndex].text
end

And(/^I select a random max price$/) do
  $selectMaxPriceIndex = rand(1..29)
  find(:xpath, $searchSectionMaxPriceDropdownXpath).all('option')[$selectMaxPriceIndex].select_option
  $selectedMaxPriceValue = find(:xpath, $searchSectionMaxPriceDropdownXpath).all('option')[$selectMaxPriceIndex].text
end

And(/^I click to Zoek button$/) do
  findAndClickToElement("xpath", $searchSectionSearchButtonXpath)
  sleepLikeABaby 3
end

Then(/^I should see my last search on the quick search component$/) do

  lastSearchText = find(:xpath, $searchSectionLastSearchCriteriasXpath).text

  if !(defined?($selectedMinPriceValue)).nil? && $selectedMinPriceValue != nil
    expect(lastSearchText).to include($selectedMinPriceValue)
  end

  if !(defined?($searchedAddress)).nil? && $searchedAddress != nil
    expect(lastSearchText).to include($searchedAddress)
  elsif expect(lastSearchText).to include("Nederland")
  end

  if !(defined?($selectedDistanceValue)).nil? && $selectedDistanceValue != nil
    if ($selectedDistanceValue != "+ 0 km")
      trimmedSelectedDistance = $selectedDistanceValue.gsub(/\s+/, "")
      expect(lastSearchText).to include(trimmedSelectedDistance)
    end
  end

  if !(defined?($selectedMaxPriceValue)).nil? && $selectedMaxPriceValue != nil
    if ($selectedMaxPriceValue != "Geen maximum")
      expect(lastSearchText).to include($selectedMaxPriceValue)
    end
  end

end

Then(/^Default active tab on search content should be "([^"]*)"$/) do |searchCategory|
  activeTab = find(:xpath, $searchSectionActiveTabXpath).text
  puts activeTab
  expect(activeTab).to eq(searchCategory)
end

And(/^I click to clear \(X\) button$/) do
  findAndClickToElement("xpath", $searchSectionAddressTextboxClearButtonXpath)
end

Then(/^I should not see any input on the address textbox$/) do
  addressTextboxInput = find(:xpath, $searchSectionAddressTextboxXpath)['value']
  expect(addressTextboxInput).to eq("")
end

And(/^I select a random max price lower than selected min price$/) do
  $selectMaxPriceIndex = rand(1..$selectMinPriceIndex - 1)
  find(:xpath, $searchSectionMaxPriceDropdownXpath).all('option')[$selectMaxPriceIndex].select_option
  $selectedMaxPriceValue = find(:xpath, $searchSectionMaxPriceDropdownXpath).all('option')[$selectMaxPriceIndex].text
  findAndClickToElement("xpath", $searchSectionAddressTextboxXpath)
end

Then(/^I should see max price font color as red$/) do
  maxPriceColor = find(:xpath, $searchSectionMaxPriceDropdownXpath).native.css_value('color')
  expect(maxPriceColor).to eq($searchSectionInvalidMaxPriceColor)
end

And(/^I select an address from autocomplete dropdown$/) do
  sleepLikeABaby 1
  $searchedAddress = find(:xpath, $searchSectionAddressAutocompleteListFirstOptionXpath).text
  find(:xpath, $searchSectionAddressAutocompleteListFirstOptionXpath).click
end

And(/^I should see related addresses on autocomplete dropdown$/) do
  sleepLikeABaby 3
  addressAutocompleteList = findAllElements("xpath", $searchSectionAddressAutocompleteListXpath)
  for item in addressAutocompleteList
    expect(item.text).to include($searchedAddress)
  end
end

And(/^I set min price as "([^"]*)"$/) do |minPrice|
  find(:xpath, $searchSectionMinPriceDropdownXpath).all('option')[0].select_option
  $setMinPriceValue = minPrice
  findElement("xpath", $searchSectionMinPriceTextboxXpath).set minPrice
end

And(/^I set max price as "([^"]*)"$/) do |maxPrice|
  find(:xpath, $searchSectionMaxPriceDropdownXpath).all('option')[0].select_option
  $setMaxPriceValue = maxPrice
  findElement("xpath", $searchSectionMaxPriceTextboxXpath).set maxPrice
end

And(/^I click to my last search$/) do
  findAndClickToElement("xpath",$searchSectionLastSearchCriteriasXpath)
end