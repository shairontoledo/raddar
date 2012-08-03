require "spec_helper"

describe VotesController do
  describe "routing" do

    it "doesn't route to #new" do
      get("/vote/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/vote").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/vote/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/vote").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/vote").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/vote").should_not be_routable
    end

    [:venue, :stuff, :comment, :post].each do |parent|

      context "nested with #{parent}" do

        it "doesn't route to #new" do
          get("/#{parent}s/#{parent}-slug/vote/new").should_not be_routable
        end

        it "doesn't route to #show" do
          get("/#{parent}s/#{parent}-slug/vote").should_not be_routable
        end

        it "doesn't route to #edit" do
          get("/#{parent}s/#{parent}-slug/vote/edit").should_not be_routable
        end

        it "routes to #create" do
          post("/#{parent}s/#{parent}-slug/vote").should route_to("votes#create", :"#{parent}_id" => "#{parent}-slug")
        end

        it "doesn't route to #update" do
          put("/#{parent}s/#{parent}-slug/vote").should_not be_routable
        end

        it "doesn't route to #destroy" do
          delete("/#{parent}s/#{parent}-slug/vote").should_not be_routable
        end
      end
    end
  end
end