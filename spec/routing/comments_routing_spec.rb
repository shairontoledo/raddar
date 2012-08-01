require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/comments").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/comments/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/comments/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/comments/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/comments").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/comments/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/comments/1").should_not be_routable
    end

    # For venues

    it "doesn't route to #index" do
      get("/venues/venue-slug/comments").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/venues/venue-slug/comments/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/venues/venue-slug/comments/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/venues/venue-slug/comments/1/edit").should_not be_routable
    end

    it "routes to #create" do
      post("/venues/venue-slug/comments").should route_to("comments#create", venue_id: 'venue-slug')
    end

    it "doesn't route to #update" do
      put("/venues/venue-slug/comments/1").should_not be_routable
    end

    it "routes to #destroy" do
      delete("/venues/venue-slug/comments/1").should route_to("comments#destroy", :id => "1", venue_id: 'venue-slug')
    end

  end
end