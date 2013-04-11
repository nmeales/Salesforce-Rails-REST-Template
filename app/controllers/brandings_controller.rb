require 'brandings'

class BrandingsController < ApplicationController
	respond_to :html, :js

  def index
  end

  def callback
  end

  def login
  end

  def find
    @branding = Brandings.find
    @products = Brandings.find_products
    @iframe_url = "#{ENV['sfdc_instance_url']}/secur/frontdoor.jsp?sid=#{ENV['sfdc_token']}"
  end

  def create
  	@response = Brandings.create(params)
  	respond_to do |format|
        format.json { render :json => @response.to_json }
  	end
  end
end
