class SessionsController < ApplicationController
  skip_before_action :authorize

  def create
    current_user.regenerate_authentication_token
    render json: current_user
  end

  def destroy
    current_user.regenerate_authentication_token
    render json: 'logged out'
  end
end
