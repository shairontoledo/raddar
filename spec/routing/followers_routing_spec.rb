require "spec_helper"

describe FollowersController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/followers").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/followers/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/followers/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/followers/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/followers").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/followers/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/followers/1").should_not be_routable
    end

    [:pub, :forum, :user].each do |parent|

      context "nested with #{parent}" do

        it "routes to #index" do
          get("/#{parent}s/#{parent}-name/followers").should route_to("followers#index", :"#{parent}_id" => "#{parent}-name")
        end

        it "doesn't route to #new" do
          get("/#{parent}s/#{parent}-name/followers/new").should_not be_routable
        end

        it "doesn't route to #show" do
          get("/#{parent}s/#{parent}-name/followers/1").should_not be_routable
        end

        it "doesn't route to #edit" do
          get("/#{parent}s/#{parent}-name/followers/1/edit").should_not be_routable
        end

        it "routes to #create" do
          post("/#{parent}s/#{parent}-name/followers").should route_to("followers#create", :"#{parent}_id" => "#{parent}-name")
        end

        it "doesn't route to #update" do
          put("/#{parent}s/#{parent}-name/followers/1").should_not be_routable
        end

        it "doesn't route to #destroy" do
          delete("/#{parent}s/#{parent}-name/followers/1").should_not be_routable
        end

        it "routes to #destroy" do
          delete("/#{parent}s/#{parent}-name/followers").should route_to('followers#destroy', :"#{parent}_id" => "#{parent}-name")
        end
      end
    end
  end
end