require "spec_helper"

describe UniversesController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/universes").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/universes/new").should_not route_to("universes#new")
    end

    it "routes to #show" do
      get("/universes/1").should route_to("universes#show", :id => "1")
    end

    it "doesn't route to #edit" do
      get("/universes/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/universes").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/universes/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/universes/1").should_not be_routable
    end

  end
end
