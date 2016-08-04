require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  def setup
    @token = tokens(:one)
  end

  test "it's not valid without specifing attributes" do
    assert_not Token.new.valid?
  end

  test "value must be present and consist of 64 characters" do
    @token.value = ""
    assert_not @token.valid?

    @token.value = "a"*127
    assert_not @token.valid?

    @token.value = "a"*129
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
