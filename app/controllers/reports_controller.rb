require 'salesforce'

class ReportsController < ApplicationController
	respond_to :html, :js

  # redirect user if session is active, otherwise follow oauth flow
  def login
  end

  # callback used to do authentication in popup window
  def callback
  end

  # display the page with a branded list of reports
  def index
    Salesforce.set_http(session[:accesstoken], session[:accessurl])
    @user = Salesforce.get_user()
    # the access token has expired so clear session and redirect to login page
    unless @user.parsed_response[0].nil?
      reset_session
      redirect_to "/reports/login"
    else
      # @branding = Salesforce.get_template(@user["id"])
      @reports = Salesforce.get_reports()
    end
  end

  # run a specific report
  def run
    Salesforce.set_http(session[:accesstoken], session[:accessurl])
  	@response = Salesforce.run_report(params)
    @describe = Salesforce.describe_report(params)
  	respond_to do |format|
        format.json { render :json => {:data => @response, :meta => @describe}.to_json}
  	end
  end
end
