require 'spec_helper'

describe KnowledgesController do
  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:knowledge) { create :knowledge }

  def valid_attributes
    {title: 'Ruby',
    description: 'Ruby description',
    publish: true}
  end

  def invalid_attributes
    {title: 'Ruby'}
  end

  describe "unauthenticated" do
    describe "GET index" do
      it "assigns the requested knowledge as @knowledge" do
        get 'index'
        response.should be_success
      end
    end

    describe "GET show" do
      it "assigns the requested knowledge as @knowledge" do
        knowledge
        get :show, {:id => knowledge.to_param}
        assigns(:knowledge).should eq(knowledge)
      end
    end

  end

  describe "authenticated" do

    before(:each) { sign_in user; knowledge }

    describe "GET index" do
      it "assigns the requested knowledge as @knowledge" do
        get 'index'
        response.should be_success
      end
    end

    describe "GET show" do
      it "assigns the requested knowledge as @knowledge" do
        knowledge
        get :show, {:id => knowledge.to_param}
        assigns(:knowledge).should eq(knowledge)
      end
    end

    describe "GET new" do
      it "assigns a new knowledge as @knowledge" do
        get :new
        assigns(:knowledge).should be_a_new(Knowledge)
      end
    end

    describe "GET edit" do
      it "assigns the requested knowledge as @knowledge" do
        knowledge
        get :edit, {:id => knowledge.to_param}
        assigns(:knowledge).should eq(knowledge)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Knowledge" do
          expect {
            post :create, {:knowledge => valid_attributes}
          }.to change(Knowledge, :count).by(1)
        end

        it "redirects to the created knowledge" do
          post :create, {:knowledge => valid_attributes}
          response.should redirect_to(Knowledge.last)
        end
      end

      describe "with invalid params" do
        it "re-renders the 'new' template" do
          Knowledge.any_instance.stub(:save).and_return(false)
          post :create, {:knowledge => invalid_attributes}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested knowledge" do
          knowledge
          # Assuming there are no other knowledges in the database, this
          # specifies that the Knowledge created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Knowledge.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
          put :update, {:id => knowledge.to_param, :knowledge => { "title" => "MyString" }}
        end

        it "assigns the requested knowledge as @knowledge" do
          not
          put :update, {:id => knowledge.to_param, :knowledge => valid_attributes}
          assigns(:knowledge).should eq(knowledge)
        end

        it "redirects to the knowledge" do
          knowledge
          put :update, {:id => knowledge.to_param, :knowledge => valid_attributes}
          response.should redirect_to(knowledge)
        end
      end

      describe "with invalid params" do
        it "re-renders the 'edit' template" do
          knowledge
          Knowledge.any_instance.stub(:save).and_return(false)
          put :update, {:id => knowledge.to_param, :knowledge => invalid_attributes}
          response.should render_template("edit")
        end
      end
    end

    #describe "DELETE destroy" do
    #  it "destroys the requested knowledge" do
    #    knowledge
    #    expect {
    #      delete :destroy, {:id => knowledge.to_param}
    #    }.to change(Knowledge, :count).by(-1)
    #  end

    #  it "redirects to the knowledges list" do
    #    knowledge
    #    delete :destroy, {:id => knowledge.to_param}
    #    response.should redirect_to(knowledges_path)
    #  end
    #end
  end
end
