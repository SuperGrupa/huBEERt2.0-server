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

  test "should update notification" do
    patch user_notification_url(@user.id, @notification), params: {
      notification: {
        event_id: @notification.event_id, message: @notification.message
      }
    }
    assert_response 200
  end
end
