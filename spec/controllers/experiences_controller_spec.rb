require 'spec_helper'

describe ExperiencesController do
  #let(:user) { create :user }
  #let(:admin) { create :admin }
  #let(:knowledge) { create :knowledge }
  #let(:experience) { create :experience, user: user, knowledge: knowledge }

  #def valid_attributes
  #  {title: 'ruby',
  #  content: 'ruby',
  #  user_id: user.id,
  #  knowledge_id: knowledge.id}
  #end

  #describe "unauthenticated" do
  #  describe "GET index" do
  #    it "always can access" do
  #      get :index
  #      response.should be_success
  #    end
  #  end

  #  describe "GET show" do
  #    it "assigns the requested experience as @experience" do
  #      experience
  #      get :show, {:id => experience.to_param}
  #      assigns(:experience).should eq(experience)
  #    end
  #  end

  #end

  #describe "authenticated" do

  #  before(:each) { sign_in user; knowledge }

  #  describe "GET new" do
  #    it "assigns a new experience as @experience" do
  #      get :new, {knowledge_id: knowledge.id}
  #      assigns(:experience).should be_a_new(Experience)
  #    end
  #  end

  #  describe "GET edit" do
  #    it "assigns the requested experience as @experience" do
  #      experience
  #      get :edit, {:id => experience.to_param}
  #      assigns(:experience).should eq(experience)
  #    end
  #  end

  #  describe "POST create" do
  #    describe "with valid params" do
  #      it "creates a new experience" do
  #        expect {
  #          post :create, {:experience => valid_attributes}
  #        }.to change(Experience, :count).by(1)
  #      end

  #      it "redirects to the created experience" do
  #        post :create, {:experience => valid_attributes}
  #        response.should redirect_to(Experience.last)
  #      end
  #    end

  #    describe "with invalid params" do
  #      it "re-renders the 'new' template" do
  #        Experience.any_instance.stub(:save).and_return(false)
  #        post :create, {:experience => { "title" => "invalid value" }}
  #        response.should render_template("new")
  #      end
  #    end
  #  end

  #  describe "PUT update" do
  #    describe "with valid params" do
  #      it "updates the requested experience" do
  #        experience
  #        # Assuming there are no other experiences in the database, this
  #        # specifies that the experience created on the previous line
  #        # receives the :update_attributes message with whatever params are
  #        # submitted in the request.
  #        Experience.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
  #        put :update, {:id => experience.to_param, :experience => { "title" => "MyString" }}
  #      end

  #      it "assigns the requested experience as @experience" do
  #        not
  #        put :update, {:id => experience.to_param, :experience => valid_attributes}
  #        assigns(:experience).should eq(experience)
  #      end

  #      it "redirects to the experience" do
  #        experience
  #        put :update, {:id => experience.to_param, :experience => valid_attributes}
  #        response.should redirect_to(experience)
  #      end
  #    end

  #    describe "with invalid params" do
  #      it "re-renders the 'edit' template" do
  #        experience
  #        Experience.any_instance.stub(:save).and_return(false)
  #        put :update, {:id => experience.to_param, :experience => { "title" => "invalid value" }}
  #        response.should render_template("edit")
  #      end
  #    end
  #  end

  #  describe "DELETE destroy" do
  #    it "destroys the requested experience" do
  #      experience
  #      expect {
  #        delete :destroy, {:id => experience.to_param}
  #      }.to change(Experience, :count).by(-1)
  #    end

  #    it "redirects to the experiences list" do
  #      experience
  #      delete :destroy, {:id => experience.to_param}
  #      response.should redirect_to(experiences_url)
  #    end
  #  end

  #  describe 'reputed' do
  #    before(:each) { sign_in admin }
  #    it 'useful' do
  #      experience
  #      expect {
  #            post :reputed, {id: experience.to_param, repute_type: 'useful' }
  #          }.to change(admin.reputations.useful, :count).by(1)
  #      #cancel useful
  #      expect {
  #            post :reputed, {id: experience.to_param, repute_type: 'useful' }
  #          }.to change(admin.reputations.useful, :count).by(-1)
  #    end

  #    it 'useless' do
  #      experience
  #      expect {
  #            post :reputed, {id: experience.to_param, repute_type: 'useless' }
  #          }.to change(admin.reputations.useless, :count).by(1)
  #      #cancel useful
  #      expect {
  #            post :reputed, {id: experience.to_param, repute_type: 'useless' }
  #          }.to change(admin.reputations.useless, :count).by(-1)
  #    end
  #  end
  #end
end
