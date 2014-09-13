class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authenticate

  respond_to :json

  protected

    def authenticate
      current_user || not_authorized
    end

    def current_user
      @current_user ||= authenticate_with_http_token do |token, options|
        User.find_by(authentication_token: token)
      end
    end

    def not_authorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'Not Authorized', status: 401
    end
end
