require "spec_helper"

describe Admin::PubsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/pubs").should route_to("admin/pubs#index")
    end

    it "routes to #new" do
      get("/admin/pubs/new").should_not route_to("admin/pubs#new")
    end

    it "routes to #show" do
      get("/admin/pubs/1").should_not route_to("admin/pubs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/pubs/1/edit").should_not route_to("admin/pubs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/pubs").should_not route_to("admin/pubs#create")
    end

    it "routes to #update" do
      put("/admin/pubs/1").should_not route_to("admin/pubs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/pubs/1").should route_to("admin/pubs#destroy", :id => "1")
    end

    it "routes to #set_main" do
      put("/admin/pubs/1/set_main").should route_to("admin/pubs#set_main", :id => "1")
    end

    it "routes to #remove_main" do
      put("/admin/pubs/1/remove_main").should route_to("admin/pubs#remove_main", :id => "1")
    end

  end
end
