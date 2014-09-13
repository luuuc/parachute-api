module Api
  module V1
    class OccurencesController < AdminController
      include Apify

      private

        def api_methods
          [:index, :show]
        end

        def identifier_column
          :name
        end

        def exception_params
          params.require(:exception).permit(:status)
        end
    end
  end
end