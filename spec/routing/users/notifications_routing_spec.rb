require "spec_helper"

describe Users::NotificationsController do
  describe "routing" do

    it "doesn't route to #new" do
      get("/users/notifications/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/users/notifications").should_not route_to("users/notifications#show")
    end

    it "routes to #edit" do
      get("/users/notifications/edit").should route_to("users/notifications#edit")
    end

    it "doesn't route to #create" do
      post("/users/notifications").should_not be_routable
    end

    it "routes to #update" do
      put("/users/notifications").should route_to("users/notifications#update")
    end

    it "doesn't route to #destroy" do
      delete("/users/notifications").should_not be_routable
    end

    it "routes to #read" do
      post("/users/notifications/read").should route_to("users/notifications#read")
    end

  end
end