module Api
  module V1
    class InvitationsController < ApplicationController
      include Apify

      before_action :authenticate_admin

      private

        def api_methods
          [:index, :show, :destroy]
        end

        def identifier_column
          :token
        end

        def invitation_params
          params.require(:invitation).permit(:name, :email, :admin, :language, :time_zone)
        end
    end
  end
end