class PubsController < ApplicationController
  before_action :set_pub, only: [:show, :update, :destroy]
  before_action :sanitize_params, only: :index

  PAGE_SIZE = 10

  # GET /pubs?page[&q]
  def index
    @pubs = Pub.where("name ILIKE ?", "%#{params[:q]}%").includes(:comments)
               .limit(PAGE_SIZE).offset((params[:page] - 1)*PAGE_SIZE)

    @total_pubs = Pub.where("name ILIKE ?", "%#{params[:q]}%").count

    render json: paginate(@pubs, @total_pubs)
  end

  # GET /pubs/1
  def show
    render json: @pub.detail_info
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
      params.require(:pub).permit(:name, :description, :phone, :email, :hidden, :city_id, :address)
    end

    # Convert :page param to integer
    def sanitize_params
      params.require([:q, :page])
      params.permit(:q, :page)

      params[:page] = params[:page].to_i
    end

    # Create hash ready for client-side pagination
    def paginate(pubs, total_pubs)
      { total_pubs: total_pubs, pubs: pubs.map { |pub| pub.general_info } }
    end
end
