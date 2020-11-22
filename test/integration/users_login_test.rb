require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:reethu)
  end

  test "login with valid email/invalid password" do
    get '/login'
    assert_template 'sessions/new'
    post '/login', params: { session: { email:    @user.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get '/login'
    post '/login', params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", '/login', count: 0
    assert_select "a[href=?]", '/logout'
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", '/login'
    assert_select "a[href=?]", '/logout',      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end