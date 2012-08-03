require "spec_helper"

describe WatchingsController do
  describe "routing" do

    it "doesn't route to #new" do
      get("/watching/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/watching").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/watching/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/watching").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/watching").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/watching").should_not be_routable
    end

    [:venue, :stuff, :topic].each do |parent|

      context "nested with topic" do

        it "doesn't route to #new" do
          get("/topics/topic-slug/watching/new").should_not be_routable
        end

        it "doesn't route to #show" do
          get("/topics/topic-slug/watching/").should_not be_routable
        end

        it "doesn't route to #edit" do
          get("/topics/topic-slug/watching/edit").should_not be_routable
        end

        it "doesn't route to #create" do
          post("/topics/topic-slug/watching").should_not be_routable
        end

        it "doesn't route to #update" do
          put("/topics/topic-slug/watching").should_not be_routable
        end

        it "routes to #destroy" do
          delete("/topics/topic-slug/watching").should route_to("watchings#destroy", :"topic_id" => "topic-slug")
        end
      end
    end

    # context "nested with a topic and a forum" do

    #   it "doesn't route to #new" do
    #     get("/forums/forum-name/topics/topic-slug/watching/new").should_not be_routable
    #   end

    #   it "doesn't route to #show" do
    #     get("/forums/forum-name/topics/topic-slug/watching/").should_not be_routable
    #   end

    #   it "doesn't route to #edit" do
    #     get("/forums/forum-name/topics/topic-slug/watching/edit").should_not be_routable
    #   end

    #   it "doesn't route to #create" do
    #     post("/forums/forum-name/topics/topic-slug/watching").should_not be_routable
    #   end

    #   it "doesn't route to #update" do
    #     put("/forums/forum-name/topics/topic-slug/watching").should_not be_routable
    #   end

    #   it "routes to #destroy" do
    #     delete("/forums/forum-name/topics/topic-slug/watching").should route_to("watchings#destroy", topic_id: "topic-slug", forum_id: 'forum-name')
    #   end
    # end
  end
end