require 'forcedotcom'

OmniAuth.config.full_host = 'https://localhost:3000'
# OmniAuth.config.full_host = 'https://peaceful-badlands-9510.herokuapp.com'

module OmniAuth
  module Strategies
    #tell omniauth to load our strategy
    autoload :Forcedotcom, 'lib/forcedotcom'
  end
end

# created a new remote access for heroku
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :forcedotcom, '3MVG9A2kN3Bn17huDuQprQMHa7If.Mib45nJI.gmakVUFyyVBgJJrF4waqlHdI3qcoG56MMIsrQIIhld6vu_4', '5449733754049641923'
end