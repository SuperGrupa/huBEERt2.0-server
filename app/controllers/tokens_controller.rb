class TokensController < ApplicationController
  before_action :set_token, only: :destroy

  # POST /tokens
  def create
    @token = Token.new(token_params)

    if @token.save
      render json: @token, status: :created, location: user_token_url(@token.user_id, @token)
    else
      render json: @token.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tokens/1
  def destroy
    @token.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = Token.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def token_params
      params.require(:token).permit(:value, :expire, :user_id)
    end
end
