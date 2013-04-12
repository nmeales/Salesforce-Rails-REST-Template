require 'brandings'

class BrandingsController < ApplicationController
	respond_to :html, :js

  def index
  end

  def callback
  end

  def login
  	begin
  		@response = Brandings.check_login
	rescue
  		@response = {}
  	end
  end

  def find
    @branding = Brandings.find(session[:accesstoken], session[:accessurl])
    @products = Brandings.find_products(session[:accesstoken], session[:accessurl])
    @company = Brandings.my_info(session[:accesstoken], session[:accessurl])
    @iframe_url = "#{session[:accessurl]}/secur/frontdoor.jsp?sid=#{session[:accesstoken]}"
  end

  def create
  	@response = Brandings.create(params, session[:accesstoken], session[:accessurl])
  	respond_to do |format|
        format.json { render :json => @response.to_json }
  	end
  end
end
