require "spec_helper"

describe TopicsController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/topics").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/topics/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/topics/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/topics/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/topics").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/topics/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/topics/1").should_not be_routable
    end

  end
end
