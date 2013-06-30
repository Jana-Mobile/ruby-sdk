require 'jana_api'

class JiaController < ApplicationController
  def fetch
    # initialize a Jana instance, fetch the link, and render it or the
    # error on the screen
    @link = nil
    @error = nil

    customerId = 'gta2i'
    secretKey = '293af117b8f14232ad86099f730629bc'
    offerId = 'irl_mim6lf'

    jana = Jana.new(customerId, secretKey, 'http://localhost:8082/api/')
    response = jana.getJIALink offerId
    
    if response['success'] 
      @link = response['link'] 
    else
      @error = response['error']
    end
  end
end
