class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :update, :destroy]
  before_action :set_pub, only: [:index]

  # GET /offers
  def index
    @offers = Offer.where(pub_id: @pub.id).includes(:beer)

    render json: @offers.map { |offer| offer.general_info }
  end

  # GET /offers/1
  def show
    render json: @offer
  end

  # POST /offers
  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      render json: @offer, status: :created, location: pub_offer_url(@offer.pub_id, @offer)
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /offers/1
  def update
    if @offer.update(offer_params)
      render json: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offers/1
  def destroy
    @offer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    def set_pub
      @pub = Pub.find(params[:pub_id])
    end

    # Only allow a trusted parameter "white list" through.
    def offer_params
      params.require(:offer).permit(:pub_id, :beer_id, :value)
    end
end
