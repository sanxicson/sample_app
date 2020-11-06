require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links" do
  	get static_pages_home_url
  	assert_template 'static_pages/home'
  	assert_select "a[href=?]", static_pages_home_url
  	assert_select "a[href=?]", '/help'
  	assert_select "a[href=?]", '/about'
  	assert_select "a[href=?]", '/contacts'
  	get '/contacts'
  	assert_select "title", full_title("Contacts")
  end
end
