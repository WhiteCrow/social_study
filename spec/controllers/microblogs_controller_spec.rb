require 'spec_helper'

describe MicroblogsController do
  let(:user) { create :user }
  let(:microblog) { create :microblog }
  let(:relay) { create :relay, relayable: microblog, user: user }

  def valid_attributes
    {
      content: 'microblog by controller spec',
      user_id: user.id,
    }
  end

  describe "authenticated" do
    before(:each) { sign_in user }

    describe "POST create" do
      describe "with valid params" do
        it "creates a new microblog" do
          expect {
            post :create, {:microblog => valid_attributes}
          }.to change(Microblog, :count).by(1)
        end

        it "creates a new audit" do
          expect {
            post :create, {:microblog => valid_attributes}
          }.to change(Audit, :count).by(1)
        end

        it "redirects to the created microblog" do
          post :create, {:note => valid_attributes}
          response.should redirect_to(root_path)
        end
      end
    end

    describe "POST relay" do
      context "relay" do
        it "creates a microblog's relay" do
          microblog
          expect {
            post :relay, {id: microblog.to_param}
          }.to change(Relay, :count).by(1)
        end

        it "creates a relay's audit" do
          microblog
          expect {
            post :relay, {id: microblog.to_param}
          }.to change(Audit, :count).by(1)
        end
      end

      context "unrelay" do
        it "destroy microblog's relay" do
          microblog
          relay
          expect {
            post :relay, {id: microblog.to_param}
          }.to change(Relay, :count).by(-1)
        end

        it "destroy relay's audit" do
          microblog
          relay
          expect {
            post :relay, {id: microblog.to_param}
          }.to change(Audit, :count).by(-1)
        end
      end
    end

    describe "Delete Destroy" do
      it "destroys the microblog" do
        microblog
        expect {
          delete :destroy, {:id => microblog.to_param}
        }.to change(Microblog, :count).by(-1)
      end

      it "destroys the microblog's audits" do
        microblog
        expect {
          delete :destroy, {:id => microblog.to_param}
        }.to change(Audit, :count).by(-1)
      end

      it "destroys the microblog's relays" do
        microblog
        relay
        expect {
          delete :destroy, {:id => microblog.to_param}
        }.to change(Relay, :count).by(-1)
      end
    end

  end

end
