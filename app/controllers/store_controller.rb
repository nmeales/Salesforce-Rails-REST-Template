require 'salesforce'

class StoreController < ApplicationController
	respond_to :html, :js

  # redirect user if session is active, otherwise follow oauth flow
  def login
  end

  # callback used to do authentication in popup window
  def callback
  end

  # display the storefront with a branded list of products
  def index
    Salesforce.set_http(session[:accesstoken], session[:accessurl])
    @user = Salesforce.get_user()
    if @user.key?("errorCode")
      reset_session
      redirect_to :controller => 'store', :action => 'login'
    else
      @branding = Salesforce.get_template(@user["id"])
      @products = Salesforce.get_products()
    end
  end

  # create the order in salesforce
  def create
    Salesforce.set_http(session[:accesstoken], session[:accessurl])
    @user = Salesforce.get_user()
  	@response = Salesforce.create_order(params, @user["id"])
  	respond_to do |format|
        format.json { render :json => @response.to_json }
  	end
  end
end
