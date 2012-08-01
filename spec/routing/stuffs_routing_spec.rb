require "spec_helper"

describe StuffsController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/stuffs").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/stuffs/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/stuffs/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/stuffs/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/stuffs").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/stuffs/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/stuffs/1").should_not be_routable
    end

  end
end
