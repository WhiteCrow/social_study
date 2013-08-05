require 'spec_helper'
describe CommentsController do

  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:note) { create :note, user_id: user.id }

  def valid_attributes
    {
      content: 'it is a comment',
      commentable_type: note.class.name,
      commentable_id: note.id
    }
  end

  before(:each) { sign_in user; note }

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {comment: valid_attributes}
        }.to change(Comment, :count).by(1)
      end

      it "not creates a new remind" do
        expect {
          post :create, {comment: valid_attributes}
        }.to change(Audit.remind, :count).by(0)
      end

      it "creates a new remind" do
        sign_in(admin)
        expect {
          post :create, {comment: valid_attributes}
        }.to change(Audit.remind, :count).by(1)
      end

      it "comment self's commetable" do
        expect {
          post :create, {comment: valid_attributes}
        }.to change(user.reminds, :count).by(0)
      end

      it "comment other user's commetable" do
        sign_in(admin)
        expect {
          post :create, {comment: valid_attributes}
        }.to change(user.reminds, :count).by(1)
      end

      it "comment other user's commetable" do
        sign_in(admin)
        expect {
          post :create, {comment: valid_attributes}
        }.to change(user.unread_reminds, :count).by(1)
      end


      it "assigns a newly created comment as @comment" do
        post :create, {comment: valid_attributes}
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      comment = user.comments.create!(valid_attributes)
      expect {
        delete :destroy, {:id => comment.to_param}
      }.to change(Comment, :count).by(-1)
    end
  end

end
