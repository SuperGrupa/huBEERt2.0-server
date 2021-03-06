require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:janusz)
    @notification = notifications(:one)
  end

  test "should get index" do
    get user_notifications_url(@user.id), params: authorizing_params(@user)
    assert_response :success
  end

  test "should update notification" do
    patch user_notification_url(@user.id, @notification), params: authorizing_params(@user).merge(
      notification: {
        event_id: @notification.event_id, message: @notification.message
      }
    )
    assert_response 200
  end
end
