require 'test_helper'

class TokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @token = tokens(:super)
    @user = users(:janusz)
  end

  test "should create token" do
    assert_difference('Token.count') do
      post tokens_url, params: {
        login: @user.login,
        password: 'qwerty'
      }
    end

    assert_response 201
  end

  test "should destroy token" do
    assert_difference('Token.count', -1) do
      delete token_url(@token), params: authorizing_params(@user)
    end

    assert_response 204
  end
end
