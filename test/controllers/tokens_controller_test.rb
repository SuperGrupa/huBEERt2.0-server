require 'test_helper'

class TokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @token = tokens(:one)
  end

  test "should create token" do
    assert_difference('Token.count') do
      post user_tokens_url(@token.user_id), params: {
        token: {
          expire: @token.expire, user_id: @token.user_id, value: @token.value
        }
      }
    end

    assert_response 201
  end

  test "should destroy token" do
    assert_difference('Token.count', -1) do
      delete user_token_url(@token.user_id, @token)
    end

    assert_response 204
  end
end
