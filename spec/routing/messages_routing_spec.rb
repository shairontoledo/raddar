require "spec_helper"

describe MessagesController do
  describe "routing" do

    it "routes to #index" do
      get("/messages").should route_to("messages#index")
    end

    it "doesn't route to #new" do
      get("/messages/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/messages/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/messages/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/messages").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/messages/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/messages/1").should_not be_routable
    end

    it "routes to #read" do
      post("/messages/read").should route_to("messages#read")
    end

    context 'nested with user' do
      it "routes to #index" do
        get("/users/user-name/messages").should route_to("messages#index", user_id: 'user-name')
      end

      it "doesn't route to #new" do
        get("/users/user-name/messages/new").should_not be_routable
      end

      it "doesn't route to #show" do
        get("/users/user-name/messages/1").should_not be_routable
      end

      it "doesn't route to #edit" do
        get("/users/user-name/messages/1/edit").should_not be_routable
      end

      it "routes to #create" do
        post("/users/user-name/messages").should route_to("messages#create", user_id: 'user-name')
      end

      it "doesn't route to #update" do
        put("/users/user-name/messages/1").should_not be_routable
      end

      it "doesn't route to #destroy" do
        delete("/users/user-name/messages/1").should_not be_routable
      end

      it "routes to #destroy_all" do
        delete("/users/user-name/messages/destroy_all").should route_to("messages#destroy_all", user_id: 'user-name')
      end

      it "routes to #more" do
        get("/users/user-name/messages/more").should route_to("messages#more", user_id: 'user-name')
      end

      it "routes to #read" do
        post("/users/user-name/messages/read").should route_to("messages#read", user_id: 'user-name')
      end
    end

  end
end
