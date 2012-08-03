require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/comments").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/comments/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/comments/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/comments/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/comments").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/comments/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/comments/1").should_not be_routable
    end

    [:venue, :stuff].each do |parent|

      context "nested with #{parent}" do

        it "doesn't route to #index" do
          get("/#{parent}s/#{parent}-slug/comments").should_not be_routable
        end

        it "doesn't route to #new" do
          get("/#{parent}s/#{parent}-slug/comments/new").should_not be_routable
        end

        it "doesn't route to #show" do
          get("/#{parent}s/#{parent}-slug/comments/1").should_not be_routable
        end

        it "doesn't route to #edit" do
          get("/#{parent}s/#{parent}-slug/comments/1/edit").should_not be_routable
        end

        it "routes to #create" do
          post("/#{parent}s/#{parent}-slug/comments").should route_to("comments#create", :"#{parent}_id" => "#{parent}-slug")
        end

        it "doesn't route to #update" do
          put("/#{parent}s/#{parent}-slug/comments/1").should_not be_routable
        end

        it "routes to #destroy" do
          delete("/#{parent}s/#{parent}-slug/comments/1").should route_to("comments#destroy", :id => "1", :"#{parent}_id" => "#{parent}-slug")
        end

      end

    end
  end
end