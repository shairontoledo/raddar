require "spec_helper"

describe Forums::PostsController do
  describe "routing" do

    it "routes to #index" do
      get("/forums/posts").should route_to("forums/posts#index")
    end

    it "routes to #new" do
      get("/forums/posts/new").should route_to("forums/posts#new")
    end

    it "routes to #show" do
      get("/forums/posts/1").should route_to("forums/posts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/forums/posts/1/edit").should route_to("forums/posts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/forums/posts").should route_to("forums/posts#create")
    end

    it "routes to #update" do
      put("/forums/posts/1").should route_to("forums/posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/forums/posts/1").should route_to("forums/posts#destroy", :id => "1")
    end

  end
end
