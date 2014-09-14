require 'rails_helper'

RSpec.describe Api::V1::Manage::UsersController, type: :controller do
  let(:admin) { create(:admin) }

  describe "with admin token" do
    before(:each) { authWithUser(admin) }

    context "GET #index" do
      let!(:users) { create_list(:user, 3) }

      before do
        get :index, format: :json
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end

      it "loads all of the users" do
        #expect(assigns(:users)).to match_array(users << admin)
        response_array = json['users'].map { |u| u['name'] }
        users_array = (users << admin).map(&:name)
        expect(response_array).to match_array users_array
      end
    end

    context "GET #show" do
      let(:user) { create(:user) }

      before do
        get :show, id: user.name, format: :json
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end
    end

    # context "POST #create" do
    #   let(:app_params) { FactoryGirl.attributes_for(:app) }

    #   before do
    #     post :create, app: app_params
    #   end

    #   it "should respond successfully with an HTTP 201 status code" do
    #     expect(response).to be_success
    #     expect(response.code).to eq("201")
    #   end
    # end

    context "PATCH #update" do
      let!(:user) { create(:user) }

      before do
        patch :update, id: user.name, user: { admin: true }
      end

      it "responds successfully with an HTTP 204 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end

      it "should have changed the user's language attribute" do
        user.reload
        expect(user.admin).to eq true
      end
    end

    context "DELETE #destroy" do
      let!(:user) { create(:user) }

      before do
        delete :destroy, id: user.name
      end

      it "responds successfully with an HTTP 204 status code" do
        expect(response).to be_success
        expect(response.code).to eq '204'
      end

      it "should destroy the user" do
        expect(User.find_by(name: user.name)).to be_nil
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
      let(:user) { create(:user) }
      before(:each) { authWithUser(user) }

      it "GET #index is unauthorized" do
        get :index, format: :json
      end

      it "GET #show is unauthorized" do
        get :show, id: admin.name, format: :json
      end
    end
  end
end
