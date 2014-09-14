require 'rails_helper'

RSpec.describe Api::V1::Manage::InvitationsController, :type => :controller do
  let(:admin) { create(:admin) }

  describe "with admin token" do
    before(:each) { authWithUser(admin) }

    context "GET #index" do
      let!(:invitations) { create_list(:invitation, 3, user: admin) }

      before do
        get :index, format: :json
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end

      it "loads all of the invitations" do
        response_array = json['invitations'].map { |a| a['email'] }
        expect(response_array).to match_array invitations.map(&:email)
      end
    end

    context "GET #show" do
      let(:invitation) { create(:invitation) }

      before do
        get :show, id: invitation.token, format: :json
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end
    end

    context "POST #create" do
      let(:invitation_params) { attributes_for(:invitation) }

      before do
        post :create, invitation: invitation_params
      end

      it "should respond successfully with an HTTP 201 status code" do
        expect(response).to be_success
        expect(response.code).to eq("201")
      end
    end

    context "DELETE #destroy" do
      let!(:invitation) { create(:invitation) }

      before do
        delete :destroy, id: invitation.token
      end

      it "responds successfully with an HTTP 204 status code" do
        expect(response).to be_success
        expect(response.code).to eq '204'
      end

      it "should destroy the invitation" do
        expect(Invitation.find_by(token: invitation.token)).to be_nil
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
      let(:invitation) { create(:invitation) }
      let(:user) { create(:user) }
      before(:each) { authWithUser(user) }

      it "GET #index is unauthorized" do
        get :index, format: :json
      end

      it "GET #show is unauthorized" do
        get :show, id: invitation.token, format: :json
      end
    end
  end
end
