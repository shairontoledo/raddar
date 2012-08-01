require "spec_helper"

describe Admin::UsersController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/users").should route_to("admin/users#index")
    end

    it "doesn't route to #new" do
      get("/admin/users/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/admin/users/1").should_not be_routable
    end

    it "routes to #edit" do
      get("/admin/users/1/edit").should route_to("admin/users#edit", :id => "1")
    end

    it "doesn't route to #create" do
      post("/admin/users").should_not be_routable
    end

    it "routes to #update" do
      put("/admin/users/1").should route_to("admin/users#update", :id => "1")
    end

    it "doesn't route to #destroy" do
      delete("/admin/users/1").should_not be_routable
    end

  end
end