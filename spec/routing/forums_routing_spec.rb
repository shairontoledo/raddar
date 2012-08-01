require "spec_helper"

describe ForumsController do
  describe "routing" do

    it "routes to #index" do
      get("/forums").should route_to("forums#index")
    end

    it "doesn't route to #new" do
      get("/forums/new").should_not route_to("forums#new")
    end

    it "routes to #show" do
      get("/forums/1").should route_to("forums#show", :id => "1")
    end

    it "doesn't route to #edit" do
      get("/forums/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/forums").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/forums/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/forums/1").should_not be_routable
    end

  end
end
