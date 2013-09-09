require 'spec_helper'

describe ReviewsController do

  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:resource) { create :resource }
  let(:review) { create :review, user: user, resource_id: resource.id }

  def valid_attributes
    {title: 'Good Website',
    content: 'It is a Good Website',
    user_id: user.id,
    resource_id: resource.id}
  end

  describe "unauthenticated" do
    describe "GET show" do
      it "assigns the requested review as @review" do
        review = Review.create! valid_attributes
        get :show, {:id => review.to_param}
        assigns(:review).should eq(review)
      end
    end
  end

  describe "authenticated" do

    before(:each) { sign_in user; resource }

    describe "GET new" do
      it "assigns a new review as @review" do
        get :new, {resource_id: resource.id}
        assigns(:review).should be_a_new(Review)
      end
    end

    describe "GET edit" do
      it "assigns the requested review as @review" do
        review
        get :edit, {:id => review.to_param}
        assigns(:review).should eq(review)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Review" do
          expect {
            post :create, {:review => valid_attributes}
          }.to change(Review, :count).by(1)
        end

        it "redirects to the created review" do
          post :create, {:review => valid_attributes}
          response.should redirect_to(Review.last)
        end
      end

      describe "with invalid params" do
        it "re-renders the 'new' template" do
          Review.any_instance.stub(:save).and_return(false)
          post :create, {:review => { "title" => "invalid value" }}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested review" do
          review
          # Assuming there are no other reviews in the database, this
          # specifies that the Review created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Review.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
          put :update, {:id => review.to_param, :review => { "title" => "MyString" }}
        end

        it "assigns the requested review as @review" do
          not
          put :update, {:id => review.to_param, :review => valid_attributes}
          assigns(:review).should eq(review)
        end

        it "redirects to the review" do
          review
          put :update, {:id => review.to_param, :review => valid_attributes}
          response.should redirect_to(review)
        end
      end

      describe "with invalid params" do
        it "re-renders the 'edit' template" do
          review
          Review.any_instance.stub(:save).and_return(false)
          put :update, {:id => review.to_param, :review => { "title" => "invalid value" }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested review" do
        review
        expect {
          delete :destroy, {:id => review.to_param}
        }.to change(Review, :count).by(-1)
      end

      it "redirects to the reviews list" do
        resource = review.resource
        delete :destroy, {:id => review.to_param}
        response.should redirect_to(resource)
      end
    end
  end
end
