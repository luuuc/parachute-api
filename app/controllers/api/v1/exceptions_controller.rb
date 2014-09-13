module Api
  module V1
    class ExceptionsController < AdminController
      include Apify

      private

        def api_methods
          [:index, :show, :update]
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
