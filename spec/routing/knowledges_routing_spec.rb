require "spec_helper"

describe KnowledgesController do
  describe "routing" do

    it "routes to #index" do
      get("/knowledges").should route_to("knowledges#index")
    end

    it "routes to #new" do
      get("/knowledges/new").should route_to("knowledges#new")
    end

    it "routes to #show" do
      get("/knowledges/1").should route_to("knowledges#show", :id => "1")
    end

    it "routes to #edit" do
      get("/knowledges/1/edit").should route_to("knowledges#edit", :id => "1")
    end

    it "routes to #create" do
      post("/knowledges").should route_to("knowledges#create")
    end

    it "routes to #update" do
      put("/knowledges/1").should route_to("knowledges#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/knowledges/1").should route_to("knowledges#destroy", :id => "1")
    end

  end
end
