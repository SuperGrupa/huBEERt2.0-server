require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @notification = notifications(:one)
  end

  test "it's not valid without specifing attributes" do
    assert_not Notification.new.valid?
  end

  test "message must be present and up to 160 characters" do
    @notification.message = ""
    assert_not @notification.valid?

    @notification.message = "a"*161
    assert_not @notification.valid?
  end

  test "read property should be boolean" do
    @notification.read = nil
    assert_not @notification.valid?
  end

  test "notification from fixture should be valid" do
    assert @notification.valid?
  end
end
