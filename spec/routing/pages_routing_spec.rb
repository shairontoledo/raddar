require "spec_helper"

describe PagesController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/pages").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/pages/new").should_not route_to("pages#new")
    end

    it "routes to #show" do
      get("/pages/1").should route_to("pages#show", :id => "1")
    end

    it "doesn't route to #edit" do
      get("/pages/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/pages").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/pages/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/pages/1").should_not be_routable
    end

  end
end
