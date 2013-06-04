class SessionsController < ApplicationController

  # set your session with the token and instance url and then redirect to the first page of your application
  def create
    session[:accesstoken] = request.env['omniauth.auth']['credentials']['token']
    session[:accessurl] = request.env['omniauth.auth']['instance_url']
    redirect_to :controller => 'salesforce', :action => 'index'
  end

  # authentication has failed so display the error message to the user
  def fail
    render :text =>  request.env["omniauth.auth"].to_yaml
  end
  
end