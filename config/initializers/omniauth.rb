require 'forcedotcom'

# OmniAuth.config.full_host = 'https://localhost:3000'
OmniAuth.config.full_host = 'https://enigmatic-reef-1137.herokuapp.com'

module OmniAuth
  module Strategies
    #tell omniauth to load our strategy
    autoload :Forcedotcom, 'lib/forcedotcom'
  end
end

# created a new remote access for heroku
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :forcedotcom, '3MVG9y6x0357HlecAjK2a9pDXrRCF5UO99bl6VUKaN57uOHsa.9TDDIESR0PDB2M9hA4Hzt0_8h_JXavJ4W8Y', '5295537183718893468'
end