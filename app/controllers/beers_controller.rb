class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :update]
  before_action :authenticate_by_token, -> { authorize(['admin']) }, except: :show

  # GET /beers
  def index
    render json: Beer.all.map { |beer| beer.general_info }
  end

  # GET /beers/1
  def show
    render json: @beer.detail_info
  end

  # POST /beers
  def create
    @beer = Beer.new(beer_params)

    if @beer.save
      render json: @beer, status: :created
    else
      render json: @beer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beers/1
  def update
    if @beer.update(beer_params)
      render json: @beer
    else
      render json: @beer.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def beer_params
      params.require(:beer).permit(:name, :description, :alcohol, :extract, :volume)
    end
end
