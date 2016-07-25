require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = events(:one)
  end

  test "it's not valid without specifing attributes" do
    assert_not Event.new.valid?
  end

  test "name must be present and up to 50 characters" do
    @event.name = ""
    assert_not @event.valid?

    @event.name = "a"*51
    assert_not @event.valid?
  end

  test "description must be present and up to 300 characters" do
    @event.name = ""
    assert_not @event.valid?

    @event.name = "a"*301
    assert_not @event.valid?
  end

  test "date must be present and placed in future" do
    @event.date = nil
    assert_not @event.valid?

    @event.date = 3.days.ago
    assert_not @event.valid?
  end

  test "event from fixture should be valid" do
    assert @event.valid?
  end
end
