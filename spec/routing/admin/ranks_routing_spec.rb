require "spec_helper"

describe Admin::RanksController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/universes/universe-slug/ranks").should route_to("admin/ranks#index", universe_id: 'universe-slug')
    end

    it "routes to #new" do
      get("/admin/universes/universe-slug/ranks/new").should route_to("admin/ranks#new", universe_id: 'universe-slug')
    end

    it "doesn't route to #show" do
      get("/admin/universes/universe-slug/ranks/1").should_not be_routable
    end

    it "routes to #edit" do
      get("/admin/universes/universe-slug/ranks/1/edit").should route_to("admin/ranks#edit", :id => "1", universe_id: 'universe-slug')
    end

    it "routes to #create" do
      post("/admin/universes/universe-slug/ranks").should route_to("admin/ranks#create", universe_id: 'universe-slug')
    end

    it "routes to #update" do
      put("/admin/universes/universe-slug/ranks/1").should route_to("admin/ranks#update", :id => "1", universe_id: 'universe-slug')
    end

    it "routes to #destroy" do
      delete("/admin/universes/universe-slug/ranks/1").should route_to("admin/ranks#destroy", :id => "1", universe_id: 'universe-slug')
    end

  end
end