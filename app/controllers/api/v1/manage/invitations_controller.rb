module Api
  module V1
    module Manage
      class InvitationsController < AdminController
        include Apify

        before_action :authenticate_admin

        private

          def api_methods
            [:index, :show, :create, :destroy]
          end

          def identifier_column
            :token
          end

          def invitation_params
            params.require(:invitation).permit(:name, :email, :admin, :language, :time_zone)
                  .merge(invited_by: current_user.id)
          end
      end
    end
  end
end