class ApplicationController < ApplicationController
  before_action :authenticate_admin

  protected

    def authenticate_admin
      (authenticate && current_user.admin) || not_authorized
    end
end
