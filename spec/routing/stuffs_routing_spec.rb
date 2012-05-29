require "spec_helper"

describe StuffsController do
  describe "routing" do

    it "routes to #index" do
      get("/stuffs").should route_to("stuffs#index")
    end

    it "routes to #new" do
      get("/stuffs/new").should route_to("stuffs#new")
    end

    it "routes to #show" do
      get("/stuffs/1").should route_to("stuffs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stuffs/1/edit").should route_to("stuffs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stuffs").should route_to("stuffs#create")
    end

    it "routes to #update" do
      put("/stuffs/1").should route_to("stuffs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stuffs/1").should route_to("stuffs#destroy", :id => "1")
    end

  end
end
