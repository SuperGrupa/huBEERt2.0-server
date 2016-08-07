class UserCommentsController < ApplicationController
  before_action :set_user, only: :index

  # GET /users/:user_id/comments
  def index
    render json: @user.comments
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
