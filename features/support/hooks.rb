#encoding: UTF-8

After do |scenario|

  if scenario.passed?
    $selectedDistanceValue = nil
    $selectedMinPriceValue = nil
    $selectedMaxPriceValue = nil
    $setMinPriceValue = nil
    $setMaxPriceValue = nil
    $searchedAddress = nil
  end
end