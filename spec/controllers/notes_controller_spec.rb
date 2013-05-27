require 'spec_helper'

describe NotesController do
  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:knowledge) { create :knowledge }
  let(:note) { create :note, user: user, knowledge: knowledge }

  def valid_attributes
    {title: 'ruby',
    content: 'ruby',
    user_id: user.id,
    knowledge_id: knowledge.id}
  end

  describe "unauthenticated" do
    describe "GET index" do
      it "always can access" do
        get :index
        response.should be_success
      end
    end

    describe "GET show" do
      it "assigns the requested note as @note" do
        note
        get :show, {:id => note.to_param}
        assigns(:note).should eq(note)
      end
    end

  end

  describe "authenticated" do

    before(:each) { sign_in user; knowledge }

    describe "GET new" do
      it "assigns a new note as @note" do
        get :new, {knowledge_id: knowledge.id}
        assigns(:note).should be_a_new(Note)
      end
    end

    describe "GET edit" do
      it "assigns the requested note as @note" do
        note
        get :edit, {:id => note.to_param}
        assigns(:note).should eq(note)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Note" do
          expect {
            post :create, {:note => valid_attributes}
          }.to change(Note, :count).by(1)
        end

        it "redirects to the created note" do
          post :create, {:note => valid_attributes}
          response.should redirect_to(Note.last)
        end
      end

      describe "with invalid params" do
        it "re-renders the 'new' template" do
          Note.any_instance.stub(:save).and_return(false)
          post :create, {:note => { "title" => "invalid value" }}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested note" do
          note
          # Assuming there are no other notes in the database, this
          # specifies that the Note created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Note.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
          put :update, {:id => note.to_param, :note => { "title" => "MyString" }}
        end

        it "assigns the requested note as @note" do
          not
          put :update, {:id => note.to_param, :note => valid_attributes}
          assigns(:note).should eq(note)
        end

        it "redirects to the note" do
          note
          put :update, {:id => note.to_param, :note => valid_attributes}
          response.should redirect_to(note)
        end
      end

      describe "with invalid params" do
        it "re-renders the 'edit' template" do
          note
          Note.any_instance.stub(:save).and_return(false)
          put :update, {:id => note.to_param, :note => { "title" => "invalid value" }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested note" do
        note
        expect {
          delete :destroy, {:id => note.to_param}
        }.to change(Note, :count).by(-1)
      end

      it "redirects to the notes list" do
        knowledge = note.knowledge
        delete :destroy, {:id => note.to_param}
        response.should redirect_to(knowledge)
      end
    end

    describe 'reputed' do
      before(:each) { sign_in admin }
      it 'useful' do
        note
        expect {
              post :reputed, {id: note.to_param, repute_type: 'useful' }
            }.to change(admin.reputations.useful, :count).by(1)
        #cancel useful
        expect {
              post :reputed, {id: note.to_param, repute_type: 'useful' }
            }.to change(admin.reputations.useful, :count).by(-1)
      end

      it 'useless' do
        note
        expect {
              post :reputed, {id: note.to_param, repute_type: 'useless' }
            }.to change(admin.reputations.useless, :count).by(1)
        #cancel useful
        expect {
              post :reputed, {id: note.to_param, repute_type: 'useless' }
            }.to change(admin.reputations.useless, :count).by(-1)
      end
    end
  end
end
