module Api
  module V1
    module Manage
      class AppsController < AdminController
        include Apify

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
end