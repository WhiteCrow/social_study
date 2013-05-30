require 'spec_helper'
describe CommentsController do

  let(:user) { create :user }
  let(:note) { create :note }

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

    it "redirects to the comments list" do
      comment = user.comments.create!(valid_attributes)
      commentable = comment.commentable
      delete :destroy, {:id => comment.to_param}
      response.should redirect_to(commentable)
    end
  end

end
