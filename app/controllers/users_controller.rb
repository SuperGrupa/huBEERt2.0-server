require 'securerandom'

class UsersController < ApplicationController
  wrap_parameters :user, include: [:login, :email, :password, :city_id]
  before_action :set_user, :authenticate_by_token, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user.general_info
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      token = @user.tokens.create!(value: SecureRandom.hex(64), expire: 1.hour.from_now)
      render json: @user.logged_info(token), status: :created
    else
      p @user.errors
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user.general_info
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    render json: @user.general_info
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:login, :email, :password, :city_id)
    end
end
