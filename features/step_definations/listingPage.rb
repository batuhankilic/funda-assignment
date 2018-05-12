Then(/^I should be at "([^"]*)" listing page$/) do |searchCategory|
  path = URI.parse(current_url).path
  expect(path).to include(searchCategory)

  searchCategory = find(:xpath, $listingPageListingCategoryXpath).text
  expect(searchCategory).to include('in koopwoningen')
end

And(/^I should see correct values on filters$/) do
  if !(defined?($selectedDistanceValue)).nil?
    distance = find(:xpath, $listingPageDistanceDropdownXpath).find('option[selected]').text
    expect(distance).to eql($selectedDistanceValue)
  end

  if !(defined?($selectedMinPriceValue)).nil?
    minPrice = find(:xpath, $listingPageMinPriceFilterXpath).find('option[selected]').text
    expect(minPrice).to eql($selectedMinPriceValue)
  end

  if !(defined?($selectedMaxPriceValue)).nil?
    maxPrice = find(:xpath, $listingPageMaxPriceFilterXpath).find('option[selected]').text
    expect(maxPrice).to eql($selectedMaxPriceValue)
  end

  if !(defined?($searchedAddress)).nil?
    address = find(:xpath, $listingPageAddressTextboxXpath)['value']
    expect(address).to include($searchedAddress)
  end

  if !(defined?($selectedMaxPriceValue)).nil?
    priceFilter = find(:xpath, $listingPageAppliedPriceFilterXpath).text
    expect(priceFilter).to include($selectedMinPriceValue)
    if ($selectedMaxPriceValue != "Geen Maximum")
      expect(priceFilter).to include($selectedMaxPriceValue)
    end
  end

end