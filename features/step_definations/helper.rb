#!/bin/env ruby
# encoding: utf-8

def set_low_timeout
  Capybara.default_max_wait_time = 2
end

def set_default_timeout
  Capybara.default_max_wait_time = 60
end

def wait_for_spinner
  Timeout.timeout(150) do
    begin
      loop do
        isSpinnerExist = true

        el = first('.spinner')
        if(el.nil?)
          isSpinnerExist = false
        end

        break if !isSpinnerExist
      end
    rescue
    end
  end
end

def wait_for_second_spinner
  Timeout.timeout(150) do
    begin
      loop do
        isSpinnerExist = true

        el = first('.blockUI.blockMsg.blockPage>img')
        if(el.nil?)
          isSpinnerExist = false
        end

        break if !isSpinnerExist
      end
    rescue
    end
  end
end


def wait_for_time_functions
  wait_for_second_spinner
  wait_for_ajax
  wait_for_spinner

end

def wait_for_ajax_woTimeOut
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

def findAndClickToElement(method, path)

  wait_for_ajax
  if(method == "xpath")
    find(:xpath, path).click
  elsif(method == "css")
    find(path).click
  end
  wait_for_ajax

end

def findElement(method, path)
  wait_for_ajax
  if(method == "xpath")
    element =  find(:xpath, path)
  elsif(method == "css")
    element =  find(path)
  end
  wait_for_ajax
  return element
end

def sleepForPageChange(second)
  sleep second
end



def checkIfElementExistXpath (xpath)
  begin
    if(find_all(:xpath, xpath).size >= 1)
      return true
    else
      return false
    end
  rescue
    return false
  end
end

def findAllElements(method,path)
  wait_for_ajax
  if(method == "xpath")
    elements =  find_all(:xpath, path)
  elsif(method == "css")
    elements =  find_all(path)
  end
  wait_for_ajax
  return elements
end

def clickElement(element)
  wait_for_ajax
  element.click
  wait_for_ajax
end

def checkIfElementNotExistWithCss (css)
  wait_for_ajax
  Capybara.default_max_wait_time = 5
  begin
    expect(find(css))
    return false
  rescue
    return true
  end
  Capybara.default_max_wait_time = 20
  wait_for_ajax
end

def sleepLikeABaby(second)
  wait_for_ajax
  sleep second
  wait_for_ajax
end
