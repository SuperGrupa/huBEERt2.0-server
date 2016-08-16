class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: :destroy
  before_action :set_user, only: [:index, :destroy]
  before_action :authenticate_by_token, only: [:index, :create, :destroy]

  # GET /users/1/subscriptions
  def index
    @subscriptions = Subscription.where(user_id: @user.id)

    render json: @subscriptions.map { |sub| sub.info }
  end

  # POST /users/1/subscriptions
  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      render json: @subscription, status: :created
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1/subscriptions/1
  def destroy
    @subscription.destroy
    render json: @user.subscriptions.map { |sub| sub.info }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a trusted parameter "white list" through.
    def subscription_params
      params.require(:subscription).permit(:user_id, :pub_id)
    end
end
