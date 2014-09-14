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
        expect(response.code).to eq("200")
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
        expect(response.code).to eq("200")
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
end
