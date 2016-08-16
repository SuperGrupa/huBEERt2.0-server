class PubsController < ApplicationController
  before_action :set_pub, only: [:show, :update, :destroy]
  before_action :sanitize_params, only: :index
  before_action :authenticate_by_token, except: [:index, :show]

  PAGE_SIZE = 10

  # GET /pubs?q&city&page
  def index
    @pubs = Pub.includes(:comments)
               .joins(:city)
               .where("pubs.name ILIKE ? AND cities.name = ? AND hidden = false",
                       "%#{params[:q]}%", params[:city])

    render json: paginate(@pubs)
  end

  # GET /pubs/1
  def show
    render json: @pub.detail_info
  end

  # POST /pubs
  def create
    @pub = Pub.new(pub_params)

    if @pub.save
      render json: @pub, status: :created
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
      params.require([:q, :page, :city])
      params.permit(:q, :page, :city)

      params[:page] = params[:page].to_i
    end

    # Create hash ready for client-side pagination
    def paginate(pubs)
      paginated_pubs = pubs.to_a.slice((params[:page] - 1)*PAGE_SIZE, PAGE_SIZE)
      { total_pubs: pubs.length, pubs: paginated_pubs.map { |pub| pub.general_info } }
    end
end
