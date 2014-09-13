module Api
  module V1
    module Manage
      class UsersController < AdminController
        include Apify

        before_action :authenticate_admin

        private

          def api_methods
            [:index, :show, :update, :destroy]
          end

          def identifier_column
            :name
          end

          def user_params
            params.require(:user).permit(:admin)
          end
      end
    end
  end
end
