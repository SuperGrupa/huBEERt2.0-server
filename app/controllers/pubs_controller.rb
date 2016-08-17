class PubsController < ApplicationController
  before_action :set_pub, only: [:show, :update, :destroy]
  before_action :sanitize_params, only: :index
  before_action :authenticate_by_token, -> { authorize(['pub-owner', 'admin']) }, only: :update
  before_action :authenticate_by_token, -> { authorize(['admin']) }, only: [:create, :destroy]

  # GET /pubs?q&city&page
  def index
    if params[:q].present? && params[:city].present?
      @pubs = Pub.includes(:comments)
                 .joins(:city)
                 .where("pubs.name ILIKE ? AND cities.name = ? AND hidden = false",
                         "%#{params[:q]}%", params[:city])
      page_size = 10
    else
      #return unless authenticate_by_token && authorize(['admin'])
      @pubs = Pub.includes(:comments).joins(:city).order(:name)
      page_size = 30
    end

    render json: paginate(@pubs, page_size)
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
    render json: @pub.detail_info
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
      params.require(:page)
      params.permit(:q, :page, :city)

      params[:page] = params[:page].to_i
    end

    # Create hash ready for client-side pagination
    def paginate(pubs, page_size)
      paginated_pubs = pubs.to_a.slice((params[:page] - 1)*page_size, page_size)
      { total_pubs: pubs.length, pubs: paginated_pubs.map { |pub| pub.general_info } }
    end
end
