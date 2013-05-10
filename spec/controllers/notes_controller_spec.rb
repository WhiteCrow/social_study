require 'spec_helper'

describe NotesController do
  let(:user) { create :user }
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
        get :new
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
        it "assigns a newly created but unsaved note as @note" do
          # Trigger the behavior that occurs when invalid params are submitted
          Note.any_instance.stub(:save).and_return(false)
          post :create, {:note => { "title" => "invalid value" }}, valid_session
          assigns(:note).should be_a_new(Note)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Note.any_instance.stub(:save).and_return(false)
          post :create, {:note => { "title" => "invalid value" }}, valid_session
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested note" do
          note = Note.create! valid_attributes
          # Assuming there are no other notes in the database, this
          # specifies that the Note created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Note.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
          put :update, {:id => note.to_param, :note => { "title" => "MyString" }}, valid_session
        end

        it "assigns the requested note as @note" do
          note = Note.create! valid_attributes
          put :update, {:id => note.to_param, :note => valid_attributes}, valid_session
          assigns(:note).should eq(note)
        end

        it "redirects to the note" do
          note = Note.create! valid_attributes
          put :update, {:id => note.to_param, :note => valid_attributes}, valid_session
          response.should redirect_to(note)
        end
      end

      describe "with invalid params" do
        it "assigns the note as @note" do
          note = Note.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Note.any_instance.stub(:save).and_return(false)
          put :update, {:id => note.to_param, :note => { "title" => "invalid value" }}, valid_session
          assigns(:note).should eq(note)
        end

        it "re-renders the 'edit' template" do
          note = Note.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Note.any_instance.stub(:save).and_return(false)
          put :update, {:id => note.to_param, :note => { "title" => "invalid value" }}, valid_session
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested note" do
        note = Note.create! valid_attributes
        expect {
          delete :destroy, {:id => note.to_param}, valid_session
        }.to change(Note, :count).by(-1)
      end

      it "redirects to the notes list" do
        note = Note.create! valid_attributes
        delete :destroy, {:id => note.to_param}, valid_session
        response.should redirect_to(notes_url)
      end
    end

  end
end
