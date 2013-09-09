require 'spec_helper'

describe ResourcesController do
  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:resource) { create :resource }

  def valid_attributes
    {title: 'Wikipidea',
    description: 'Wikipidea description',
    publish: true}
  end

  def invalid_attributes
    {title: 'Ruby'}
  end

  describe "unauthenticated" do
    describe "GET index" do
      it "assigns the requested resource as @resource" do
        get 'index'
        response.should be_success
      end
    end

    describe "GET show" do
      it "assigns the requested resource as @resource" do
        resource
        get :show, {:id => resource.to_param}
        assigns(:resource).should eq(resource)
      end
    end

  end

  describe "authenticated" do

    before(:each) { sign_in user; resource }

    describe "GET index" do
      it "assigns the requested resource as @resource" do
        get 'index'
        response.should be_success
      end
    end

    describe "GET show" do
      it "assigns the requested resource as @resource" do
        resource
        get :show, {:id => resource.to_param}
        assigns(:resource).should eq(resource)
      end
    end

    describe "GET new" do
      it "assigns a new resource as @resource" do
        get :new
        assigns(:resource).should be_a_new(Resource)
      end
    end

    describe "GET edit" do
      it "assigns the requested resource as @resource" do
        resource
        get :edit, {:id => resource.to_param}
        assigns(:resource).should eq(resource)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Resource" do
          expect {
            post :create, {:resource => valid_attributes}
          }.to change(Resource, :count).by(1)
        end

        it "redirects to the created resource" do
          post :create, {:resource => valid_attributes}
          response.should redirect_to(Resource.last)
        end
      end

      describe "with invalid params" do
        it "re-renders the 'new' template" do
          Resource.any_instance.stub(:save).and_return(false)
          post :create, {:resource => invalid_attributes}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested resource" do
          resource
          # Assuming there are no other resources in the database, this
          # specifies that the Resource created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Resource.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
          put :update, {:id => resource.to_param, :resource => { "title" => "MyString" }}
        end

        it "assigns the requested resource as @resource" do
          not
          put :update, {:id => resource.to_param, :resource => valid_attributes}
          assigns(:resource).should eq(resource)
        end

        it "redirects to the resource" do
          resource
          put :update, {:id => resource.to_param, :resource => valid_attributes}
          response.should redirect_to(resource)
        end
      end

      describe "with invalid params" do
        it "re-renders the 'edit' template" do
          resource
          Resource.any_instance.stub(:save).and_return(false)
          put :update, {:id => resource.to_param, :resource => invalid_attributes}
          response.should render_template("edit")
        end
      end
    end

    #describe "DELETE destroy" do
    #  it "destroys the requested resource" do
    #    resource
    #    expect {
    #      delete :destroy, {:id => resource.to_param}
    #    }.to change(Resource, :count).by(-1)
    #  end

    #  it "redirects to the resources list" do
    #    resource
    #    delete :destroy, {:id => resource.to_param}
    #    response.should redirect_to(resources_path)
    #  end
    #end
  end
end
