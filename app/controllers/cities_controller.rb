class CitiesController < ApplicationController
  # GET /cities
  def index
    @cities = City.all

    render json: @cities
  end
end
