require 'test_helper'

class BeersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beer = beers(:pils)
    @user = users(:janusz)
  end

  test "should create beer" do
    assert_difference('Beer.count') do
      post beers_url, params: authorizing_params(@user).merge(
        beer: { alcohol: @beer.alcohol, description: @beer.description, extract: @beer.extract, name: @beer.name, volume: @beer.volume }
      )
    end

    assert_response 201
  end

  test "should show beer" do
    get beer_url(@beer)
    assert_response :success
  end

  test "should update beer" do
    patch beer_url(@beer), params: authorizing_params(@user).merge(
      beer: { alcohol: @beer.alcohol, description: @beer.description, extract: @beer.extract, name: @beer.name, volume: @beer.volume }
    )
    assert_response 200
  end
end
