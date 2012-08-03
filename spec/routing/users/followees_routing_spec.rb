require "spec_helper"

describe Users::FolloweesController do
  describe "routing" do

    context 'nested with user' do

      it "routes to #index" do
        get("/users/user-name/followees").should route_to("users/followees#index", user_id: 'user-name')
      end

      it "doesn't route to #new" do
        get("/users/user-name/followees/new").should_not be_routable
      end

      it "doesn't route to #show" do
        get("/users/user-name/followees/1").should_not be_routable
      end

      it "doesn't route to #edit" do
        get("/users/user-name/followees/1/edit").should_not be_routable
      end

      it "doesn't route to #create" do
        post("/users/user-name/followees").should_not be_routable
      end

      it "doesn't route to #update" do
        put("/users/user-name/followees/1").should_not be_routable
      end

      it "doesn't route to #destroy" do
        delete("/users/user-name/followees/1").should_not be_routable
      end
    end
  end
end