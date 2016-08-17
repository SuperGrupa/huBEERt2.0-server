require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
    @user = users(:janusz)
  end

  test "should get index" do
    get user_subscriptions_url(@subscription.user_id), params: authorizing_params(@user)
    assert_response :success
  end

  test "should create subscription" do
    assert_difference('Subscription.count') do
      post user_subscriptions_url(@subscription.user_id), params: authorizing_params(@user).merge(
        subscription: {
          pub_id: @subscription.pub_id, user_id: @subscription.user_id
        }
      )
    end

    assert_response 201
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete user_subscription_url(@subscription.user_id, @subscription), params: authorizing_params(@user)
    end

    assert_response 200
  end
end
