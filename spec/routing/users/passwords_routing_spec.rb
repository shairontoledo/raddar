require "spec_helper"

describe Users::PasswordsController do
  describe "routing" do

    it "routes to #change" do
      get("/users/password/change").should route_to("users/passwords#change")
    end

    it "routes to #do_change" do
      put("/users/password/change").should route_to("users/passwords#do_change")
    end
  end
end