require "spec_helper"

describe Forums::TopicsController do
  describe "routing" do

    it "routes to #index" do
      get("/forums/topics").should route_to("forums/topics#index")
    end

    it "routes to #new" do
      get("/forums/topics/new").should route_to("forums/topics#new")
    end

    it "routes to #show" do
      get("/forums/topics/1").should route_to("forums/topics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/forums/topics/1/edit").should route_to("forums/topics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/forums/topics").should route_to("forums/topics#create")
    end

    it "routes to #update" do
      put("/forums/topics/1").should route_to("forums/topics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/forums/topics/1").should route_to("forums/topics#destroy", :id => "1")
    end

  end
end
