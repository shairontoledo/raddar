require "spec_helper"

describe Users::AccountsController do
  describe "routing" do

    it "routes to #index" do
      get("/users/accounts").should route_to("users/accounts#index")
    end

    it "doesn't route to #new" do
      get("/users/accounts/new").should_not route_to("users/accounts#new")
    end

    it "doesn't route to #show" do
      get("/users/accounts/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/users/accounts/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/users/accounts").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/users/accounts/1").should_not be_routable
    end

    it "routes route to #destroy" do
      delete("/users/accounts/1").should route_to('users/accounts#destroy', id: '1')
    end

  end
end
