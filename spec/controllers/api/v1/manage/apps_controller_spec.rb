require 'rails_helper'

RSpec.describe Api::V1::Manage::AppsController, type: :controller do
  let(:admin) { create(:admin) }

  describe "with admin token" do
    before(:each) { authWithUser(admin) }

    context "GET #index" do
      let!(:apps) { create_list(:app, 2) }

      before do
        get :index, format: :json
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end

      it "loads all of the apps" do
        response_array = json['apps'].map { |a| a['name'] }
        expect(response_array).to match_array apps.map(&:name)
      end
    end

    context "GET #show" do
      let(:app) { create(:app) }

      before do
        get :show, id: app.name, format: :json
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end
    end

    context "POST #create" do
      let(:app_params) { attributes_for(:app) }

      before do
        post :create, app: app_params
      end

      it "should respond successfully with an HTTP 201 status code" do
        expect(response).to be_success
        expect(response.code).to eq("201")
      end
    end

    context "PATCH #update" do
      let!(:app) { create(:app) }
      let(:changes) { 'blah/bluh' }

      before do
        patch :update, id: app.name, app: { repo_path: changes }
      end

      it "responds successfully with an HTTP 204 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end

      it "should have changed the app's language attribute" do
        app.reload
        expect(app.repo_path).to eq changes
      end
    end

    context "DELETE #destroy" do
      let!(:app) { create(:app) }

      before do
        delete :destroy, id: app.name
      end

      it "responds successfully with an HTTP 204 status code" do
        expect(response).to be_success
        expect(response.code).to eq '204'
      end

      it "should destroy the app" do
        expect(App.find_by(name: app.name)).to be_nil
      end
    end
  end

  describe "without admin token" do
    after(:each) { expect(response.status).to eq(401) }

    context "No token" do
      before(:each) { clearToken }

      it "GET #index is unauthorized" do
        get :index, format: :json
      end

      it "GET #show is unauthorized" do
        get :show, id: admin.name, format: :json
      end
    end

    context "User token" do
      let(:app) { create(:app) }
      let(:user) { create(:user) }
      before(:each) { authWithUser(user) }

      it "GET #index is unauthorized" do
        get :index, format: :json
      end

      it "GET #show is unauthorized" do
        get :show, id: app.name, format: :json
      end
    end
  end
end
