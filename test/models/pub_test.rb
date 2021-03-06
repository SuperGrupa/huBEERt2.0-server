require 'test_helper'

class PubTest < ActiveSupport::TestCase
  def setup
    @pub = pubs(:one)
  end

  test "it's not valid without specifing attributes" do
    assert_not Pub.new.valid?
  end

  test "name must be present and up to 30 characters" do
    @pub.name = ""
    assert_not @pub.valid?

    @pub.name = "a"*31
    assert_not @pub.valid?
  end

  test "description must be present and up to 160 characters" do
    @pub.description = ""
    assert_not @pub.valid?

    @pub.description = "a"*301
    assert_not @pub.valid?
  end

  test "phone must be integer" do
    @pub.phone = "abc"
    assert_not @pub.valid?
  end

  test "email must be unique and in proper format" do
    new_pub = @pub.dup
    assert_not new_pub.valid?

    @pub.email = "abc"
    assert_not @pub.valid?

    @pub.email = "abc@def"
    assert_not @pub.valid?

    @pub.email = "abc.def@gmail.com-"
    assert_not @pub.valid?
  end

  test "hidden must be boolean value" do
    @pub.hidden = nil
    assert_not @pub.valid?

    @pub.hidden = ""
    assert_not @pub.valid?
  end

  test "address must be present and up to 50 characters" do
    @pub.address = ""
    assert_not @pub.valid?

    @pub.address = "a"*51
    assert_not @pub.valid?
  end

  test "pub from fixture should be valid" do
    assert @pub.valid?
  end
end
