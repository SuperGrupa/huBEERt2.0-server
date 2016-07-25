require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get pub_events_url(@event.pub_id)
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post pub_events_url(@event.pub_id), params: {
        event: {
          date: @event.date, description: @event.description, name: @event.name, pub_id: @event.pub_id
        }
      }
    end

    assert_response 201
  end

  test "should show event" do
    get pub_event_url(@event.pub_id, @event)
    assert_response :success
  end

  test "should update event" do
    patch pub_event_url(@event.pub_id, @event), params: {
      event: {
        date: @event.date, description: @event.description, name: @event.name, pub_id: @event.pub_id
      }
    }
    assert_response 200
  end
end
