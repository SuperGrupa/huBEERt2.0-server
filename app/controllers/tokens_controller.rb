require 'securerandom'

class TokensController < ApplicationController
  before_action :set_token, only: :destroy
  before_action :set_user, only: :create

  # POST /tokens
  def create
    unless @user.authenticate(params[:password])
      render json: { password: 'jest nieprawidłowe' }, status: :unprocessable_entity and return
    end

    @token = @user.tokens.build(value: SecureRandom.hex(64), expire: 1.hour.from_now)

    if @token.save
      render json: @user.logged_info(@token), status: :created
    else
      render json: @token.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tokens/1
  def destroy
    @expired_tokens = Token.where("user_id = ? AND expire < ? AND id != ?",
                                  @token.user_id, Time.now, @token.id)
    @expired_tokens.each do |token|
      token.destroy
    end

    @token.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      params.require(:token)

      @token = Token.find(params[:id])
      if @token.nil? || @token.value != params[:token]
        render json: { token: 'jest nieprawidłowy' }, status: :unauthorized unless @token
      end
    end

    # Find user based on received login
    def set_user
      @user = User.find_by(login: params[:login])
      render json: { login: 'jest nieprawidłowy' }, status: :unprocessable_entity unless @user
    end
end
