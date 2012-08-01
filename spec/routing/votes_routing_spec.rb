require "spec_helper"

describe VotesController do
  describe "routing" do

    it "doesn't route to #new" do
      get("/vote/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/vote").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/vote/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/vote").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/vote").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/vote").should_not be_routable
    end

    # For venues

    it "doesn't route to #new" do
      get("/venues/venue-slug/vote/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/venues/venue-slug/vote").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/venues/venue-slug/vote/edit").should_not be_routable
    end

    it "routes to #create" do
      post("/venues/venue-slug/vote").should route_to("votes#create", venue_id: 'venue-slug')
    end

    it "doesn't route to #update" do
      put("/venues/venue-slug/vote").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/venues/venue-slug/vote").should_not be_routable
    end

  end
end