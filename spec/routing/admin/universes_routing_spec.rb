require "spec_helper"

describe Admin::UniversesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/universes").should route_to("admin/universes#index")
    end

    it "routes to #new" do
      get("/admin/universes/new").should route_to("admin/universes#new")
    end

    it "doesn't route to #show" do
      get("/admin/universes/1").should_not be_routable
    end

    it "routes to #edit" do
      get("/admin/universes/1/edit").should route_to("admin/universes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/universes").should route_to("admin/universes#create")
    end

    it "routes to #update" do
      put("/admin/universes/1").should route_to("admin/universes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/universes/1").should route_to("admin/universes#destroy", :id => "1")
    end

  end
end
