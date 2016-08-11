require 'test_helper'

class OffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offer = offers(:one)
  end

  test "should get index" do
    get pub_offers_url(@offer.pub_id)
    assert_response :success
  end

  test "should create offer" do
    assert_difference('Offer.count') do
      post pub_offers_url(@offer.pub_id), params: {
        offer: {
          beer_id: @offer.beer_id, pub_id: @offer.pub_id, value: @offer.value
        }
      }
    end

    assert_response 201
  end

  test "should update offer" do
    patch pub_offer_url(@offer.pub_id, @offer), params: {
      offer: {
        beer_id: @offer.beer_id, pub_id: @offer.pub_id, value: @offer.value
      }
    }
    assert_response 200
  end

  test "should destroy offer" do
    assert_difference('Offer.count', -1) do
      delete pub_offer_url(@offer.pub_id, @offer)
    end

    assert_response 204
  end
end
