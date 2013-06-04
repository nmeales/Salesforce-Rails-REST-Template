require 'salesforce'

class SalesforceController < ApplicationController
	respond_to :html, :js

  # find the current users information
  def index
    Salesforce.set_http(session[:accesstoken], session[:accessurl])
    @user = Salesforce.get_user()
    # the access token has expired so clear session and redirect to login page
    unless @user.parsed_response[0].nil?
      reset_session
      redirect_to "/reports/login"
    # session is active so get some data
    else
      # get the users current branding template
      # @branding = Salesforce.get_template(@user["id"])
    end
  end

  # create a new chatter post
  def post
    Salesforce.set_http(session[:accesstoken], session[:accessurl])
  	@response = Salesforce.create_post(params)
  	respond_to do |format|
        format.json { render :json => @response.to_json}
        # example of multiple reponses mapped to one object
        # format.json { render :json => {:data => @response, :meta => @describe}.to_json}
  	end
  end
end
