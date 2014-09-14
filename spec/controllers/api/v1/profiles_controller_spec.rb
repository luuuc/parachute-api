require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, :type => :controller do
  let(:user) { create(:user) }

  describe "with user token" do
    before(:each) { authWithUser(user) }

    context "GET #show" do
      let(:user) { create(:user) }

      before do
        get :show, format: :json
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end

      it "loads the authenticated user record" do
        expect(json['name']).to eq user.name
      end
    end

    context "PATCH #update" do
      let!(:user) { create(:user) }
      let(:changes) { 'blah@bluh.com' }

      before do
        patch :update, id: user.name, profile: { email: changes }
      end

      it "responds successfully with an HTTP 204 status code" do
        expect(response).to be_success
        expect(response.code).to eq '200'
      end

      it "should have changed the user's language attribute" do
        user.reload
        expect(user.email).to eq changes
      end
    end

  end

  describe "without token" do
    after(:each) { expect(response.status).to eq(401) }
    before(:each) { clearToken }

    it "GET #show is unauthorized" do
      get :show, format: :json
    end
  end
end
