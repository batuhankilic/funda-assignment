Given(/^I am at homepage$/) do

  visit $liveDomain
  sleep 1

end

Given(/^I am at homepage as "([^"]*)" on "([^"]*)" environment$/) do |user, environment|
  if user == 'guest'
    if environment == 'LIVE'
      visit $liveDomain
      sleepLikeABaby 1
      #In case of network security block:
      if checkIfElementExistXpath("//*[@class='content col-lg-8 col-sm-7']")
        visit $liveDomain
        sleepLikeABaby 1
      end
    elsif environment=='QA'
      visit $qaDomain
      sleepLikeABaby 1
      #In case of network security block:
      if checkIfElementExistXpath("//*[@class='content col-lg-8 col-sm-7']")
        visit $qaDomain
        sleepLikeABaby 1
      end
    end

  elsif user == 'Batuhan'
    if environment == 'LIVE'
      visit $liveDomain
      findAndClickToElement("xpath", $headerLoginButtonXpath)
      findElement("xpath", $logInPageEmailTextBoxXpath).set $emailForBatuhan
      findElement("xpath", $logInPagePasswordTextBoxXpath).set $passwordForBatuhan
      findAndClickToElement("xpath", $logInPageLoginButtonXpath)
    elsif environment=='QA'
      visit $qaDomain
      sleepLikeABaby 1
      #In case of network security block:
      if checkIfElementExistXpath("//*[@class='content col-lg-8 col-sm-7']")
        visit $qaDomain
        sleepLikeABaby 1
      end
    end
  end
end