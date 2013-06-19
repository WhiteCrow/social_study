require 'spec_helper'

describe StatesController do

  let(:user) { create :user }
  let(:microblog) { create :microblog }
  let(:relay) { create :relay, relayable: microblog, user: user }

  describe "authenticated" do
    before(:each) { sign_in user }

    describe "GET 'show'" do
      it "returns http success" do
        state = microblog.history_tracks.to_a.first
        get 'show', {id: state.to_param}
        response.should be_success
      end
    end

    describe "Delete destroy" do
      it "destroys the microblog" do
        state = microblog.history_tracks.to_a.first
        expect {
          delete :destroy, {:id => state.to_param}
        }.to change(Microblog, :count).by(-1)
      end

      it "destroys the microblog's audits" do
        state = microblog.history_tracks.to_a.first
        expect {
          delete :destroy, {:id => state.to_param}
        }.to change(Audit, :count).by(-1)
      end

      it "destroys the microblog's relays" do
        microblog
        relay
        state = microblog.history_tracks.to_a.first
        expect {
          delete :destroy, {:id => state.to_param}
        }.to change(Relay, :count).by(-1)
      end

      it "destroys the microblog and it's relays' audits" do
        microblog
        relay
        state = microblog.history_tracks.to_a.first
        expect {
          delete :destroy, {:id => state.to_param}
        }.to change(Audit, :count).by(-2)
      end
    end

    describe "POST relay" do
      context "relay" do
        it "creates a microblog's relay" do
          state = microblog.history_tracks.to_a.first
          expect {
            post :relay, {id: state.to_param}
          }.to change(Relay, :count).by(1)
        end

        it "creates a relay's audit" do
          state = microblog.history_tracks.to_a.first
          expect {
            post :relay, {id: state.to_param}
          }.to change(Audit, :count).by(1)
        end
      end

      context "unrelay" do
        it "destroy microblog's relay" do
          microblog
          relay
          state = microblog.history_tracks.to_a.first
          expect {
            post :relay, {id: state.to_param}
          }.to change(Relay, :count).by(-1)
        end

        it "destroy relay's audit" do
          microblog
          relay
          state = microblog.history_tracks.to_a.first
          expect {
            post :relay, {id: state.to_param}
          }.to change(Audit, :count).by(-1)
        end
      end
    end
  end
end
