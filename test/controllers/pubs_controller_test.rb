require 'test_helper'

class PubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pub = pubs(:one)
    @city = cities(:one)
    @admin = users(:admin)
    @janusz = users(:janusz)
  end

  test "should get index" do
    get pubs_url, params: { page: 1, q: 'double', city: @city.name }
    assert_response :success
  end

  test "should create pub" do
    assert_difference('Pub.count') do
      post pubs_url, params: authorizing_params(@admin).merge(
        pub: {
          description: @pub.description, email: 'abc@def.com', hidden: @pub.hidden, name: @pub.name, phone: @pub.phone,
          address: @pub.address, city_id: @city.id
        }
      )
    end

    assert_response 201
  end

  test "should show pub" do
    get pub_url(@pub)
    assert_response :success
  end

  test "should update pub" do
    put pub_url(@pub), params: authorizing_params(@janusz).merge(
      pub: {
        description: @pub.description, email: @pub.email, hidden: @pub.hidden, name: @pub.name, phone: @pub.phone
      }
    )
    assert_response 200
  end

  test "should destroy pub" do
    assert_difference('Pub.count', -1) do
      delete pub_url(@pub), params: authorizing_params(@admin)
    end

    assert_response 200
  end
end
