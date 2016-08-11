class UserCommentsController < ApplicationController
  before_action :set_user, :authenticate_by_token, only: :index

  # GET /users/:user_id/comments
  def index
    render json: @user.comments.map { |comment| comment.general_info }
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
