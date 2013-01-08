require "spec_helper"

describe MicroblogsController do
  describe "routing" do

    it "routes to #index" do
      get("/microblogs").should route_to("microblogs#index")
    end

    it "routes to #new" do
      get("/microblogs/new").should route_to("microblogs#new")
    end

    it "routes to #show" do
      get("/microblogs/1").should route_to("microblogs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/microblogs/1/edit").should route_to("microblogs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/microblogs").should route_to("microblogs#create")
    end

    it "routes to #update" do
      put("/microblogs/1").should route_to("microblogs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/microblogs/1").should route_to("microblogs#destroy", :id => "1")
    end

  end
end
