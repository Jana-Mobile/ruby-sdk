
require 'base64'
require 'json'
require 'openssl'
require 'net/http'
require 'uri'

DEFAULT_API_URL = 'https://api.jana.com/api/'
MAX_NONCE = 999999999

class Jana
  def initialize(clientId, secretKey, apiBaseUrl=nil)
    @clientId = clientId
    @secretKey = secretKey
    @apiBaseUrl = DEFAULT_API_URL
    if apiBaseUrl
      @apiBaseUrl = apiBaseUrl
    end
  end

  def getJIALink(offerId)
    data = self.baseRequestData
    data['method'] = 'jia-request'
    data['offer'] = offerId
    
    encoded = self.encodeData data
    sig = self.signData encoded
    
    return self.postToJana(encoded, sig, 'jia-request')
  end 

  def postToJana(data, sig, method)
    uri = URI.parse(@apiBaseUrl + method)
    response = Net::HTTP.post_form(uri, 
                                   { 
                                     'request' => data,
                                     'sig' => sig
                                   })
    parsed = JSON.parse response.body
    return parsed
  end

  def signData(data)
    sig = OpenSSL::HMAC.digest('sha256', @secretKey, data)
    encodedSig = Base64.urlsafe_encode64 sig
    return encodedSig
  end

  def encodeData(data)
    asJson = JSON.dump data
    urlSafe = Base64.urlsafe_encode64 asJson
    return urlSafe
  end

  def baseRequestData
    result = Hash.new
    result['algorithm'] = 'HMAC-SHA256'
    result['timestamp'] = Time.now.to_i
    result['nonce'] = rand(MAX_NONCE)
    result['client_id'] = @clientId
    return result
  end
end
