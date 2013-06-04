require 'forcedotcom'

OmniAuth.config.full_host = 'https://localhost:3000'
# OmniAuth.config.full_host = 'https://enigmatic-reef-1137.herokuapp.com'

module OmniAuth
  module Strategies
    #tell omniauth to load our strategy
    autoload :Forcedotcom, 'lib/forcedotcom'
  end
end

# created a new remote access for heroku
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :forcedotcom, '3MVG99OxTyEMCQ3gOgPet4shLaB9zQe4hdFQEp46hddgZTEyFaRNqwX5n7GgK8ivfKPVDjymB3PxxtAXSD5Og', '6148682134370122460'
end