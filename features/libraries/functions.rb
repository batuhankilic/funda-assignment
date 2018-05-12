# encoding: utf-8

def isPasswordTrue password

  if find_by_id('password').value.length != password.length
    find_by_id('password').set password
    isPasswordTrue password
  end
end

# -- Filte uygula button

def clickFiltreUygulabutton
  element=find(:xpath,"//*[@id='applyBtn']/div").click
end
def clickFiltreleButton
  element=find(:xpath,"//*[@id='filterBtn']").click
end

#----Check the order date if it's correct for selected filter option

def isOrderCreatedDateCorrect assertText, time

  clickFiltreUygulabutton
  element=find('#FilterTxt').text
  expect(element).to eq(assertText)
  myOrdersCount=find_all('.order-date')
  for i in myOrdersCount
    sayi=(Date.today - Date.parse(i.text)).to_i
    expect(sayi).to be <time
  end
end

#--------Check if the year correct for orders

def isOrderCreatedYearCorrect assertText,year
  clickFiltreUygulabutton
  element=find('#FilterTxt').text
  expect(element).to eq(assertText)
  myOrdersCount=find_all('.order-date')
  for i in myOrdersCount
     sayi=(i.text[-4,4]).to_i
     expect(year).to eq(sayi)

  end
end

#-----------------------Web check if the order year is correct

def isWebOrederCreatedDateYearCorrect assertText,year

  elememnt=find(:xpath,"//*[@id='ctl00_ContentPlaceHolder1_divOrderDateFilter']").text
  expect(elememnt).to eq(assertText)
  orderCreateDate=find_all(:xpath,"//*[@class='OrderDate']")

  for i in orderCreateDate
    i=Date.parse(i.text).to_s
    sayi=(i[0,4]).to_i
    expect(year).to eq(sayi)
  end

end


def ordersFilter
  options = find_all('.radio>label>input')
  #click random filter option

  randomOptions=(rand() * 7).to_i
  verifyPage = [ '(Son 30 gün)', '(Son 6 ay)', '(2017)','(2016)','(2015)','(2014)','(2013)' ]
  verifyOrder=[31,181,2017,2016,2015,2014,2013]

  for i in 0..6
    if i == randomOptions
      options[i].click
      if i<2
      isOrderCreatedDateCorrect verifyPage[i], verifyOrder[i]
      elsif i>1
      isOrderCreatedYearCorrect verifyPage[i],verifyOrder[i]
    end
  end
  end
end

#----------------------------

def isPasswordTrueForMobile password

  if find(:xpath, "//*[@id='form-login']/div[2]/div/input").value.length != password.length
    find(:xpath, "//*[@id='form-login']/div[2]/div/input").set password
    isPasswordTrueForMobile password
  end
end


def wait_for_ajax

  beginTime = Time.now.to_i
  begin
    loop do
      active = page.evaluate_script('jQuery.active')
      isComplete = page.evaluate_script('document.readyState')
      break if Time.now.to_i - beginTime == 80
      break if active == 0 && isComplete == 'complete'
    end
  rescue
  end
end