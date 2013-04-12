require 'rubygems'
require 'httparty'

class Brandings
  include HTTParty

  format :json

  def self.set_headers
    headers 'Authorization' => "OAuth #{request.env['omniauth.auth']['credentials']['token']}"
  end

  def self.root_url
    @root_url = request.env['omniauth.auth']['instance_url']+"/services/data/v"+ENV['sfdc_api_version']
  end

  def self.check_login
    Brandings.set_headers
    response = get(Brandings.root_url+"/chatter/users/me/")
  end

  def self.my_info
    Brandings.set_headers
    response = get(Brandings.root_url+"/chatter/users/me/")
  end
  
  def self.find
    Brandings.set_headers
    response = get(Brandings.root_url+"/chatter/users/me/")
    response = get(Brandings.root_url+"/sobjects/User/"+response["id"])
    soql = "SELECT Back_Background_G_B__c,Back_Background_G_T__c,Back_Body_G_B__c,Back_Body_G_T__c,Back_Button_G_B__c,Back_Button_G_T__c,Back_Button_H_G_B__c,Back_Button_H_G_T__c,Back_Footer_G_B__c,Back_Footer_G_T__c,Back_Google_Chart_1__c,Back_Google_Chart_2__c,Back_Google_Chart_3__c,Back_Google_Chart_4__c,Back_Header_B_G_B__c,Back_Header_B_G_T__c,Back_Header_Mid_G_B__c,Back_Header_Mid_G_T__c,Back_Header_T_G_B__c,Back_Header_T_G_T__c,Back_Navigation_Menu_H__c,Back_Navigation_Menu__c,Back_Page_Block_G_B__c,Back_Page_Block_G_T__c,Back_Page_Block_Header_G_B__c,Back_Page_Block_Header_G_T__c,Back_Page_Block_Table_Even__c,Back_Page_Block_Table_Odd__c,Back_Side_Button_G_B__c,Back_Side_Button_G_T__c,Back_Side_Button_H_G_B__c,Back_Side_Button_H_G_T__c,Back_Side_G_B__c,Back_Side_G_T__c,Back_Side_Module_G_B__c,Back_Side_Module_G_T__c,Back_Side_Module_Header_G_B__c,Back_Side_Module_Header_G_T__c,Back_Side__c,Back_Tab_A_G_B__c,Back_Tab_A_G_T__c,Back_Tab_G_B__c,Back_Tab_G_T__c,Back_Tab_H_G_B__c,Back_Tab_H_G_T__c,Component_Approvals__c,Component_Articles__c,Component_Cases__c,Component_Charts__c,Component_Entitlements__c,Component_Ideas__c,Component_Image__c,Component_Leads__c,Component_Products__c,Component_Solutions__c,ConnectionReceivedId,ConnectionSentId,CreatedById,CreatedDate,Font_Colour_Button_H__c,Font_Colour_Button__c,Font_Colour_Main__c,Font_Colour_Navigation_Menu_H__c,Font_Colour_Navigation_Menu__c,Font_Colour_Page_Title__c,Font_Colour_Secondary_Title__c,Font_Colour_Side_Button_H__c,Font_Colour_Side_Button__c,Font_Colour_Side_Header__c,Font_Colour_Small_Information__c,Font_Colour_Tab_A__c,Font_Colour_Tab_H__c,Font_Colour_Tab__c,Font_Decoration_Button_H__c,Font_Decoration_Button__c,Font_Decoration_Main__c,Font_Decoration_Navigation_Menu_H__c,Font_Decoration_Navigation_Menu__c,Font_Decoration_Page_Title__c,Font_Decoration_Secondary_Title__c,Font_Decoration_Side_Button_H__c,Font_Decoration_Side_Button__c,Font_Decoration_Side_Header__c,Font_Decoration_Small_Information__c,Font_Decoration_Tab_A__c,Font_Decoration_Tab_H__c,Font_Decoration_Tab__c,Font_Size_Button_H__c,Font_Size_Button__c,Font_Size_Main__c,Font_Size_Navigation_Menu_H__c,Font_Size_Navigation_Menu__c,Font_Size_Page_Title__c,Font_Size_Secondary_Title__c,Font_Size_Side_Button_H__c,Font_Size_Side_Button__c,Font_Size_Side_Header__c,Font_Size_Small_Information__c,Font_Size_Tab_A__c,Font_Size_Tab_H__c,Font_Size_Tab__c,Font_Transform_Button_H__c,Font_Transform_Button__c,Font_Transform_Main__c,Font_Transform_Navigation_Menu_H__c,Font_Transform_Navigation_Menu__c,Font_Transform_Page_Title__c,Font_Transform_Secondary_Title__c,Font_Transform_Side_Button_H__c,Font_Transform_Side_Button__c,Font_Transform_Side_Header__c,Font_Transform_Small_Information__c,Font_Transform_Tab_A__c,Font_Transform_Tab_H__c,Font_Transform_Tab__c,Font_Weight_Button_H__c,Font_Weight_Button__c,Font_Weight_Main__c,Font_Weight_Navigation_Menu_H__c,Font_Weight_Navigation_Menu__c,Font_Weight_Page_Title__c,Font_Weight_Secondary_Title__c,Font_Weight_Side_Button_H__c,Font_Weight_Side_Button__c,Font_Weight_Side_Header__c,Font_Weight_Small_Information__c,Font_Weight_Tab_A__c,Font_Weight_Tab_H__c,Font_Weight_Tab__c,Id,Image_Background_Image__c,Image_Background_Position__c,Image_Background_Repeat__c,Image_Background__c,Image_Body__c,Image_Button_H__c,Image_Button__c,Image_Footer__c,Image_Logo__c,Image_Page_Block_Header__c,Image_Slide1__c,Image_Slide2__c,Image_Slide3__c,IsDeleted,LastModifiedById,LastModifiedDate,Logo__c,Name,OwnerId,Position_Footer__c,Position_Page__c,Position_Sidebar__c,Position_Slider__c,Position_Tabs__c,Radius_Button__c,Radius_Page_Block__c,Radius_Side_Button__c,Radius_Side_Module__c,Radius_Side__c,Radius_Tab__c,Shadow_Body__c,Shadow_Header__c,Shadow_Page_Block__c,Shadow_Side_Module__c,Shadow_Side__c FROM Org_Template__c WHERE Name = \'" + response["Branding_Template__c"] + "\'"
    get(Brandings.root_url+"/query/?q=#{CGI::escape(soql)}")
  end

  def self.find_products
    Brandings.set_headers
    soql = "SELECT Id, Name, Description, purl__c FROM Product2"
    get(Brandings.root_url+"/query/?q=#{CGI::escape(soql)}")
  end

  def self.create(params)
    Brandings.set_headers
    headers 'Content-Type' => "application/json"

    response = get(Brandings.root_url+"/chatter/users/me/")
    userid = response["id"]

    options = {
      :body => {
          :name => params[:contactfirstname] + ' ' + params[:contactlastname]
      }.to_json
    }
    response = post(Brandings.root_url+"/sobjects/Account", options)
    accountid = response["id"]
    
    options = {
      :body => {
          :firstname => params[:contactfirstname],
          :lastname => params[:contactlastname],
          :email => params[:contactemail],
          :mailingcity => params[:contactcity],
          :mailingstreet => params[:contactstreet],
          :mailingpostalcode => params[:contactpostalcode],
          :mailingcountry => params[:contactcountry],
          :phone => params[:contactphone],
          :mobilephone => params[:contactmobile],
          :accountid => accountid
      }.to_json
    }
    response = post(Brandings.root_url+"/sobjects/Contact", options)
    contactid = response["id"]

    options = {
      :body => {
          :name => params[:productname],
          :contactid => contactid,
          :status => "Purchased",
          :Product2Id => params[:productid],
          :quantity => "1"
      }.to_json
    }
    response = post(Brandings.root_url+"/sobjects/Asset", options)
    assetid = response["id"]

    options = {
      :body => {
          :whatid => assetid,
          :whoid => contactid,
          :subject => params[:activitysubject],
          :status => "Not Started",
          :type => "Meeting",
          :priority => "Normal",
          :ownerid => userid,
          :activitydate => params[:activitydate]
      }.to_json
    }
    response = post(Brandings.root_url+"/sobjects/Task", options)
  end

end