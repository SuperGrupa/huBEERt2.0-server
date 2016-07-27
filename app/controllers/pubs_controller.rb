class PubsController < ApplicationController
  before_action :set_pub, only: [:show, :update, :destroy]

  # GET /pubs
  def index
    if params[:q]
      @pubs = Pub.where("name ILIKE ?", "%#{params[:q]}%").includes(:comments)
    else
      @pubs = Pub.all.includes(:comments)
    end

    render json: @pubs.map { |pub| { name: pub.name, rating: pub.rating } }
  end

  # GET /pubs/1
  def show
    render json: @pub
  end

  # POST /pubs
  def create
    @pub = Pub.new(pub_params)

    if @pub.save
      render json: @pub, status: :created, location: @pub
    else
      render json: @pub.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pubs/1
  def update
    if @pub.update(pub_params)
      render json: @pub
    else
      render json: @pub.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pubs/1
  def destroy
    @pub.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pub
      @pub = Pub.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pub_params
      params.require(:pub).permit(:name, :description, :phone, :email, :hidden)
    end
end
