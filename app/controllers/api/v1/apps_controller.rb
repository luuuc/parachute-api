module Api
  module V1
    class AppsController < ApplicationController
      include Apify

      before_action :authenticate_admin

      private

        def identifier_column
          :name
        end

        def app_params
          params.require(:app).permit(:name, :repo_provider, :repo_path, :repo_branch)
        end
    end
  end
end