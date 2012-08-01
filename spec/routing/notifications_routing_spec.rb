require "spec_helper"

describe NotificationsController do
  describe "routing" do

    it "routes to #index" do
      get("/notifications").should route_to("notifications#index")
    end

    it "doesn't route to #new" do
      get("/notifications/new").should_not route_to("notifications#new")
    end

    it "routes to #show" do
      get("/notifications/1").should route_to("notifications#show", :id => "1")
    end

    it "doesn't route to #edit" do
      get("/notifications/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/notifications").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/notifications/1").should_not be_routable
    end

    it "routes to #destroy" do
      delete("/notifications/1").should route_to("notifications#destroy", :id => "1")
    end

    it "routes to #read" do
      post("/notifications/read").should route_to("notifications#read")
    end

  end
end