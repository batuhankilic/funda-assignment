Given(/^I am at homepage$/) do

  visit $liveDomain
  sleep 1

end

Given(/^I am at homepage as "([^"]*)"$/) do |user|

  if user == 'guest'
    visit $liveDomain
    sleepLikeABaby 1
    #In case of network security block:
    if checkIfElementExistXpath("//*[@class='content col-lg-8 col-sm-7']")
      visit $liveDomain
      sleepLikeABaby 1
    end

  elsif user == 'Batuhan'
    visit $liveDomain
    findAndClickToElement("xpath", $headerLoginButtonXpath)
    findElement("xpath", $logInPageEmailTextBoxXpath).set $emailForBatuhan
    findElement("xpath", $logInPagePasswordTextBoxXpath).set $passwordForBatuhan
    findAndClickToElement("xpath", $logInPageLoginButtonXpath)
  end

end