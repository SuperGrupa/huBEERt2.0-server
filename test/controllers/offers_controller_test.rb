require 'test_helper'

class OffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offer = offers(:one)
  end

  test "should get index" do
    get offers_url
    assert_response :success
  end

  test "should create offer" do
    assert_difference('Offer.count') do
      post offers_url, params: { offer: { beer_id: @offer.beer_id, pub_id: @offer.pub_id, value: @offer.value } }
    end

    assert_response 201
  end

  test "should show offer" do
    get offer_url(@offer)
    assert_response :success
  end

  test "should update offer" do
    patch offer_url(@offer), params: { offer: { beer_id: @offer.beer_id, pub_id: @offer.pub_id, value: @offer.value } }
    assert_response 200
  end

  test "should destroy offer" do
    assert_difference('Offer.count', -1) do
      delete offer_url(@offer)
    end

    assert_response 204
  end
end
