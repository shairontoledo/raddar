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

    context 'nested with forum' do
      it "doesn't route to #index" do
        get("/forums/forum-name/topics").should_not be_routable
      end

      it "routes to #new" do
        get("/forums/forum-name/topics/new").should route_to("topics#new", forum_id: 'forum-name')
      end

      it "routes to #show" do
        get("/forums/forum-name/topics/1").should route_to("topics#show", :id => "1", forum_id: 'forum-name')
      end

      it "routes to #edit" do
        get("/forums/forum-name/topics/1/edit").should route_to("topics#edit", :id => "1", forum_id: 'forum-name')
      end

      it "routes to #create" do
        post("/forums/forum-name/topics").should route_to("topics#create", forum_id: 'forum-name')
      end

      it "routes to #update" do
        put("/forums/forum-name/topics/1").should route_to("topics#update", :id => "1", forum_id: 'forum-name')
      end

      it "routes to #destroy" do
        delete("/forums/forum-name/topics/1").should route_to("topics#destroy", :id => "1", forum_id: 'forum-name')
      end
    end
  end
end
