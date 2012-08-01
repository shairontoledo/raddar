require "spec_helper"

describe UsersController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/users").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/users/new").should_not route_to("users#new")
    end

    it "routes to #show" do
      get("/users/1").should route_to("users#show", :id => "1")
    end

    it "doesn't route to #edit" do
      get("/users/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/users").should_not route_to('users#create')
    end

    it "doesn't route to #update" do
      put("/users/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/users/1").should_not be_routable
    end

  end
end