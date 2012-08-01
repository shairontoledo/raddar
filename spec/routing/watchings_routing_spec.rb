require "spec_helper"

describe WatchingsController do
  describe "routing" do

    it "doesn't route to #new" do
      get("/watching/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/watching").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/watching/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/watching").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/watching").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/watching").should_not be_routable
    end

    # For venues

    it "doesn't route to #new" do
      get("/venues/venue-slug/watching/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/venues/venue-slug/watching/").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/venues/venue-slug/watching/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/venues/venue-slug/watching").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/venues/venue-slug/watching").should_not be_routable
    end

    it "routes to #destroy" do
      delete("/venues/venue-slug/watching").should route_to("watchings#destroy", venue_id: 'venue-slug')
    end

  end
end