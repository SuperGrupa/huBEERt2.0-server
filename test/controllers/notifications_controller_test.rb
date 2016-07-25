require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @notification = notifications(:one)
  end

  test "should get index" do
    get user_notifications_url(@user.id)
    assert_response :success
  end

  test "should create notification" do
    assert_difference('Notification.count') do
      post user_notifications_url(@user.id), params: {
        notification: {
          event_id: @notification.event_id, message: @notification.message
        }
      }
    end

    assert_response 201
  end

  test "should show notification" do
    get user_notification_url(@user.id, @notification)
    assert_response :success
  end

  test "should update notification" do
    patch user_notification_url(@user.id, @notification), params: {
      notification: {
        event_id: @notification.event_id, message: @notification.message
      }
    }
    assert_response 200
  end

  test "should destroy notification" do
    assert_difference('Notification.count', -1) do
      delete user_notification_url(@user.id, @notification)
    end

    assert_response 204
  end
end
