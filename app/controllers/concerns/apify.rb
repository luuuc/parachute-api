module Apify
  extend ActiveSupport::Concern

  included do
    before_action :not_implemented, only: [:index, :show, :create, :update, :destroy]
    before_action :resource, only: [:show, :update, :destroy]
  end

  # GET /api/v{api_version}/{plural_resource_name}
  def index
    respond_with resource_class.page(params[:page]).per(per_page)
  end

  # GET /api/v{api_version}/{plural_resource_name}/{id}
  def show
    respond_with resource
  end

  # POST /api/v{api_version}/{plural_resource_name}
  def create
    resource = resource_class.new(resource_params)

    if resource.save
      render json: resource, status: :created
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  # PATCH /api/v{api_version}/{plural_resource_name}/{id}
  def update
    if resource.update(resource_params)
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v{api_version}/{plural_resource_name}/{id}
  def destroy
    @resource.destroy
    head :no_content
  end

  private

    def not_implemented
      unless api_methods.include?(action_name.to_sym)
        render json: "#{controller_name}##{action_name} not implemented.", status: :not_found
        return
      end
    end

    def api_methods
      [:index, :show, :create, :update, :destroy]
    end

    def resource
      resource_class.find_by(resource_identifier => params[:id])
    end

    def resource_class
      resource_name.classify.constantize
    end

    def resource_name
      self.controller_name.singularize
    end

    def resource_identifier
      self.send("identifier_column") || :id
    end

    def resource_params
      resource_params ||= self.send("#{resource_name}_params")
    end

    def per_page
      current_user ? current_user.per_page : User::DEFAULT_PER_PAGE
    end
end
