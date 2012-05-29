require "spec_helper"

describe PubsController do
  describe "routing" do

    it "routes to #index" do
      get("/pubs").should route_to("pubs#index")
    end

    it "routes to #new" do
      get("/pubs/new").should route_to("pubs#new")
    end

    it "routes to #show" do
      get("/pubs/1").should route_to("pubs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pubs/1/edit").should route_to("pubs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pubs").should route_to("pubs#create")
    end

    it "routes to #update" do
      put("/pubs/1").should route_to("pubs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pubs/1").should route_to("pubs#destroy", :id => "1")
    end

  end
end
