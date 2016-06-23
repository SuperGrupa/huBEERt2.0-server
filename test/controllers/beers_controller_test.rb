require 'test_helper'

class BeersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beer = beers(:one)
  end

  test "should get index" do
    get beers_url
    assert_response :success
  end

  test "should create beer" do
    assert_difference('Beer.count') do
      post beers_url, params: { beer: { alcohol: @beer.alcohol, description: @beer.description, extract: @beer.extract, name: @beer.name, volume: @beer.volume } }
    end

    assert_response 201
  end

  test "should show beer" do
    get beer_url(@beer)
    assert_response :success
  end

  test "should update beer" do
    patch beer_url(@beer), params: { beer: { alcohol: @beer.alcohol, description: @beer.description, extract: @beer.extract, name: @beer.name, volume: @beer.volume } }
    assert_response 200
  end

  test "should destroy beer" do
    assert_difference('Beer.count', -1) do
      delete beer_url(@beer)
    end

    assert_response 204
  end
end
