# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OmniauthDemo::Application.initialize!

# Set our api version for Force.com
ENV['sfdc_api_version'] = '27.0'
