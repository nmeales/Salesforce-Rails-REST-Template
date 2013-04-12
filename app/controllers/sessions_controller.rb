require "brandings"

class SessionsController < ApplicationController
  def create
    # ENV['sfdc_token'] = request.env['omniauth.auth']['credentials']['token']
    # ENV['sfdc_instance_url'] = request.env['omniauth.auth']['instance_url']

    session[:accesstoken] = request.env['omniauth.auth']['credentials']['token']
    session[:accessurl] = request.env['omniauth.auth']['instance_url']

    redirect_to :controller => 'brandings', :action => 'callback'
  end
  def fail
    render :text =>  request.env["omniauth.auth"].to_yaml
  end
end