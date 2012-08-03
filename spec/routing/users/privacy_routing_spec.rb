require "spec_helper"

describe Users::PrivacyController do
  describe "routing" do

    it "doesn't route to #new" do
      get("/users/privacy/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/users/privacy").should_not route_to("users/privacy#show")
    end

    it "routes to #edit" do
      get("/users/privacy/edit").should route_to("users/privacy#edit")
    end

    it "doesn't route to #create" do
      post("/users/privacy").should_not be_routable
    end

    it "routes to #update" do
      put("/users/privacy").should route_to("users/privacy#update")
    end

    it "doesn't route to #destroy" do
      delete("/users/privacy").should_not be_routable
    end

  end
end