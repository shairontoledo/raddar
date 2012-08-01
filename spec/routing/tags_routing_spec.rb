require "spec_helper"

describe TagsController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/tags").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/tags/new").should_not route_to("tags#new")
    end

    it "routes to #show" do
      get("/tags/1").should route_to("tags#show", :id => "1")
    end

    it "doesn't route to #edit" do
      get("/tags/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/tags").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/tags/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/tags/1").should_not be_routable
    end

  end
end