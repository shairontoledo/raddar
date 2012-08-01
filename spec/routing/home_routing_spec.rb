require "spec_helper"

describe HomeController do
  describe "routing" do

    it "routes to #search" do
      get("/search").should route_to("home#search")
    end

    it "routes to #index" do
      get("/").should route_to("home#index")
    end

  end
end