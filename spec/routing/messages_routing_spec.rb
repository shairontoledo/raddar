require "spec_helper"

describe MessagesController do
  describe "routing" do

    it "routes to #index" do
      get("/messages").should route_to("messages#index")
    end

    it "doesn't route to #new" do
      get("/messages/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/messages/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/messages/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/messages").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/messages/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/messages/1").should_not be_routable
    end

  end
end
