require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get '/signup'
    assert_response :success
    assert_select "title", "Signup | Ruby on Rails Tutorial Sample App"
  end

end
