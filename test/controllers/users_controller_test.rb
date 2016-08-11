require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:janusz)
    @city = cities(:one)
  end

  test "should create user" do
    unique = {
      login: 'admin1',
      email: 'abc@def.com'
    }

    assert_difference('User.count') do
      post users_url, params: {
        user: {
          email: unique[:email], login: unique[:login], password: 'qwerty',
        }
      }
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), params: authorizing_params(@user)
    assert_response :success
  end

  test "should update user" do
    put user_url(@user), params: authorizing_params(@user).merge(
      user: {
        email: @user.email, login: @user.login, city_id: @city.id
      }
    )
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), params: authorizing_params(@user)
    end

    assert_response 200
  end
end
