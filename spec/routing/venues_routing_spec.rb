require "spec_helper"

describe VenuesController do
  describe "routing" do

    it "routes to #index" do
      get("/venues").should route_to("venues#index")
    end

    it "routes to #new" do
      get("/venues/new").should route_to("venues#new")
    end

    it "routes to #show" do
      get("/venues/1").should route_to("venues#show", :id => "1")
    end

    it "doesn't route to #edit" do
      get("/venues/1/edit").should_not be_routable
    end

    it "routes to #create" do
      post("/venues").should route_to("venues#create")
    end

    it "doesn't route to #update" do
      put("/venues/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/venues/1").should_not be_routable
    end

    it "routes to #nearby" do
      get("/venues/nearby").should route_to('venues#nearby')
    end

  end
end
