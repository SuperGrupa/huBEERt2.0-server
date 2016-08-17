require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
    @user = users(:janusz)
  end

  test "should get index" do
    get pub_events_url(@event.pub_id)
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post pub_events_url(@event.pub_id), params: authorizing_params(@user).merge(
        event: {
          date: @event.date, description: @event.description, name: @event.name, pub_id: @event.pub_id
        }
      )
    end

    assert_response 201
  end

  test "should update event" do
    patch pub_event_url(@event.pub_id, @event), params: authorizing_params(@user).merge(
      event: {
        date: @event.date, description: @event.description, name: @event.name, pub_id: @event.pub_id
      }
    )
    assert_response 200
  end
end
