class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update]
  before_action :set_pub, only: [:index]

  # GET /events
  def index
    @events = Event.where("pub_id = :pub_id AND date > :now",
                          { pub_id: @pub.id, now: Time.now })

    render json: @events.map { |event| event.detail_info }
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: pub_event_url(@event.pub_id, @event)
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
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
