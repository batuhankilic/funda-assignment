Then(/^I should be at "([^"]*)" listing page$/) do |searchCategory|
  path = URI.parse(current_url).path
  expect(path).to include(searchCategory)

  searchCategoryText = find(:xpath, $listingPageListingCategoryXpath).text
  expect(searchCategoryText).to include(searchCategory)
end

And(/^I should see correct values on filters$/) do
  if !(defined?($selectedDistanceValue)).nil? && $selectedDistanceValue != nil
    distance = find(:xpath, $listingPageDistanceDropdownXpath).find('option[selected]').text
    expect(distance).to eql($selectedDistanceValue)
  end

  if !(defined?($selectedMinPriceValue)).nil? && $selectedMinPriceValue!=nil
    minPrice = find(:xpath, $listingPageMinPriceFilterXpath).find('option[selected]').text
    expect(minPrice).to eql($selectedMinPriceValue)
  end

  if !(defined?($selectedMaxPriceValue)).nil? && $selectedMaxPriceValue!=nil
    maxPrice = find(:xpath, $listingPageMaxPriceFilterXpath).find('option[selected]').text
    expect(maxPrice).to eql($selectedMaxPriceValue)
  end

  if !(defined?($setMinPriceValue)).nil? && $setMinPriceValue!=nil
    minPrice = find(:xpath, $listingPageMinPriceFilterValueXpath).text.gsub(/[.]/, '')
    expect(minPrice).to eql($setMinPriceValue)
  end

  if !(defined?($setMaxPriceValue)).nil? && $setMaxPriceValue!=nil
    maxPrice = find(:xpath, $listingPageMaxPriceFilterValueXpath).text.gsub(/[.]/, '')
    expect(maxPrice).to eql($setMaxPriceValue)
  end

  if !(defined?($searchedAddress)).nil? && $searchedAddress!=nil
    address = find(:xpath, $listingPageAddressTextboxXpath)['value']
    expect(address).to include($searchedAddress)
  elsif
    address = find(:xpath, $listingPageAddressTextboxXpath)['value']
    expect(address).to include("Nederland")
  end

  if !(defined?($selectedMaxPriceValue)).nil? && $selectedMaxPriceValue!=nil
    priceFilter = find(:xpath, $listingPageAppliedPriceFilterXpath).text
    if ($selectedMaxPriceValue != "Geen maximum")
      expect(priceFilter).to include($selectedMaxPriceValue)
    end
  end

  if !(defined?($selectedMinPriceValue)).nil? && $selectedMinPriceValue!=nil
    priceFilter = find(:xpath, $listingPageAppliedPriceFilterXpath).text
    expect(priceFilter).to include($selectedMinPriceValue)
  end

  if !(defined?($setMaxPriceValue)).nil? && $setMaxPriceValue!=nil
    priceFilter = find(:xpath, $listingPageAppliedPriceFilterXpath).text.gsub(/[.]/, '')
    expect(priceFilter).to include($setMaxPriceValue)
  end

  if !(defined?($setMinPriceValue)).nil? && $setMinPriceValue!=nil
    priceFilter = find(:xpath, $listingPageAppliedPriceFilterXpath).text.gsub(/[.]/, '')
    expect(priceFilter).to include($setMaxPriceValue)
  end

end