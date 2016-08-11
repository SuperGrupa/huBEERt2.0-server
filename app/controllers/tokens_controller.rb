require 'securerandom'

class TokensController < ApplicationController
  wrap_parameters false

  before_action :set_user, :authenticate_by_password, only: :create
  before_action :set_token, :authenticate_by_token, only: :destroy

  # POST /tokens
  def create
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
        unauthorized(token: 'jest nieprawidłowy')
      end
    end

    # Find user based on received login
    def set_user
      @user = User.find_by(login: params[:login])
    end
end
