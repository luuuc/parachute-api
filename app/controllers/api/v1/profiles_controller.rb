module Api
  module V1
    class ProfilesController < ApplicationController
      def show
        respond_with current_user
      end

      def update
        if current_user.update(profile_params)
          render json: current_user
        else
          render json: current_user.errors, status: :unprocessable_entity
        end
      end

      private

        def profile_params
          params.require(:profile).permit(:name, :email, :password, :password_confirmation, :language, :time_zone, :per_page)
        end
    end
  end
end