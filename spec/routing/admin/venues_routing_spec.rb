require "spec_helper"

describe Admin::VenuesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/venues").should route_to("admin/venues#index")
    end

    it "doesn't route to #new" do
      get("/admin/venues/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/admin/venues/1").should_not be_routable
    end

    it "routes to #edit" do
      get("/admin/venues/1/edit").should route_to("admin/venues#edit", :id => "1")
    end

    it "doesn't route to #create" do
      post("/admin/venues").should_not be_routable
    end

    it "routes to #update" do
      put("/admin/venues/1").should route_to("admin/venues#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/venues/1").should route_to("admin/venues#destroy", :id => "1")
    end

  end
end
