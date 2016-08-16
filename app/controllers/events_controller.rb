class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update]
  before_action :set_pub, only: [:index, :create]
  before_action :authenticate_by_token, except: :index

  # GET /pubs/:pub_id/events
  def index
    @events = Event.where("pub_id = :pub_id AND date > :now",
                          { pub_id: @pub.id, now: Time.now })

    render json: @events.map { |event| event.detail_info }
  end

  # GET /pubs/:pub_id/events/:event_id
  def show
    render json: @event.detail_info
  end

  # POST /pubs/:pub_id/events
  def create
    @event = @pub.events.create!(event_params)

    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pubs/:pub_id/events/:event_id
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_pub
      @pub = Pub.find(params[:pub_id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:pub_id, :name, :date, :description)
    end
end
