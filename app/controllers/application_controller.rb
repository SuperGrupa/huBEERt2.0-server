class ApplicationController < ActionController::API
  def authenticate_by_token
    return false unless prepare_user(:token)

    unless @user.tokens.where("value = ? AND expire > ?", params[:token], Time.now)
      unauthorized(token: 'jest nieprawidłowy') and return false
    end
    true
  end

  def authenticate_by_password
    return false unless prepare_user(:password)

    unless @user.authenticate(params[:password])
      unauthorized(password: 'jest nieprawidłowe') and return false
    end
    true
  end

  def unauthorized(reason)
    render json: reason, status: :unauthorized
  end

  private

    def prepare_user(auth_method)
      unless params[:login].present? && params[auth_method].present?
        unauthorized(login: 'jest nieprawidłowy') and return false
      end

      @user = User.find_by(login: params[:login])
      unless @user
        unauthorized(login: 'jest nieprawidłowy') and return false
      end
      true
    end
end
