require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  def setup
    @fixture = tokens(:one)
    @token = Token.create!(value: "a"*64, expire: 10.minutes.from_now, user_id: @fixture.user_id)
  end

  test "it's not valid without specifing attributes" do
    assert_not Token.new.valid?
  end

  test "value must be present and consist of 64 characters" do
    @token.value = ""
    assert_not @token.valid?

    @token.value = "a"*63
    assert_not @token.valid?

    @token.value = "a"*65
    assert_not @token.valid?
  end

  test "expire must be less than 2 hours from now" do
    @token.expire = 1.minute.ago
    assert_not @token.valid?

    @token.expire = 3.hours.from_now
    assert_not @token.valid?
  end

  test "token from fixture should be valid" do
    assert @token.valid?
  end

end
