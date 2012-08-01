require "spec_helper"

describe PostsController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/posts").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/posts/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/posts/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/posts/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/posts").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/posts/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/posts/1").should_not be_routable
    end

  end
end
