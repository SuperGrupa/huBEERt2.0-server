require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
  end

  test "should get index" do
    get user_subscriptions_url(@subscription.user_id)
    assert_response :success
  end

  test "should create subscription" do
    assert_difference('Subscription.count') do
      post user_subscriptions_url(@subscription.user_id), params: {
        subscription: {
          pub_id: @subscription.pub_id, user_id: @subscription.user_id
        }
      }
    end

    assert_response 201
  end

  test "should show subscription" do
    get user_subscription_url(@subscription.user_id, @subscription)
    assert_response :success
  end

  test "should update subscription" do
    patch user_subscription_url(@subscription.user_id, @subscription), params: {
      subscription: {
        pub_id: @subscription.pub_id, user_id: @subscription.user_id
      }
    }
    assert_response 200
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete user_subscription_url(@subscription.user_id, @subscription)
    end

    assert_response 204
  end
end
