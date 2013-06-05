require 'spec_helper'

describe MicroblogsController do
  let(:user) { create :user }
  let(:microblog) { create :microblog }

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
      it "creates a new relay" do
        microblog
        expect {
          post :relay, {id: microblog.id}
        }.to change(Relay, :count).by(1)
      end

      it "creates a new audit" do
        microblog
        expect {
          post :relay, {id: microblog.id}
        }.to change(Audit, :count).by(1)
      end
    end
  end

end
