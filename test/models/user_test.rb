require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "it's not valid without specifing attributes" do
    assert_not User.new.valid?
  end

  test "login must be present, unique and up to 20 characters" do
    @user.login = ""
    assert_not @user.valid?

    @user.login = "a"*21
    assert_not @user.valid?

    new_user = @user.dup
    assert_not new_user.valid?
  end

  test "email must be present, unique and in specific format" do
    @user.email = ""
    assert_not @user.valid?

    new_user = @user.dup
    assert_not new_user.valid?

    @user.email = "abc"
    assert_not @user.valid?
  end

  test "user from fixture should be valid" do
    assert @user.valid?
  end
end
