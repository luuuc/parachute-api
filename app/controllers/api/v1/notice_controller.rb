class Api::V1::NoticeController < ApplicationController
  skip_before_action :authenticate

  def create
    notice = Notice.new(notice_params)

    if notice.authorized?
      if notice.save
        render json: "Exception saved"
      else
        render json: "An error occured", status: 500
      end
    else
      render json: "Unknown API key", status: 422
    end
  end
end
