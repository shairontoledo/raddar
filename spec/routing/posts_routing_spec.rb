require "spec_helper"

describe PostsController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/forums/forum-name/posts").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/forums/forum-name/posts/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/forums/forum-name/posts/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/forums/forum-name/posts/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/forums/forum-name/posts").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/forums/forum-name/posts/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/posts/1").should_not be_routable
    end

    context 'nested with a topic and a forum' do

      it "doesn't route to #index" do
        get("/forums/forum-name/topics/topic-name/posts").should_not be_routable
      end

      it "doesn't route to #new" do
        get("/forums/forum-name/topics/topic-name/posts/new").should_not be_routable
      end

      it "doesn't route to #show" do
        get("/forums/forum-name/topics/topic-name/posts/1").should_not be_routable
      end

      it "doesn't route to #edit" do
        get("/forums/forum-name/topics/topic-name/posts/1/edit").should_not be_routable
      end

      it "routes to #create" do
        post("/forums/forum-name/topics/topic-name/posts").should route_to("posts#create", topic_id: 'topic-name', forum_id: 'forum-name')
      end

      it "doesn't route to #update" do
        put("/forums/forum-name/topics/topic-name/posts/1").should_not be_routable
      end

      it "routes to #destroy" do
        delete("/forums/forum-name/topics/topic-name/posts/1").should route_to('posts#destroy', id: '1', topic_id: 'topic-name', forum_id: 'forum-name')
      end
    end

  end
end
