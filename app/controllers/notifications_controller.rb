class NotificationsController < ApplicationController
  before_action :set_notification, only: :update
  before_action :set_user, only: :index
  before_action :authenticate_by_token

  # GET /users/:user_id/notifications
  def index
    @notifications = Notification.where("user_id = ? AND read = false", @user.id)

    render json: @notifications.map { |notify| notify.info }
  end

  # PATCH/PUT /users/:user_id/notifications/1
  def update
    if @notification.update(notification_params)
      render json: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Set user who requests the notifications
    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a trusted parameter "white list" through.
    def notification_params
      params.require(:notification).permit(:read)
    end
end
