require "spec_helper"

describe Admin::HomeController do
  describe "routing" do

    it "routes to #index" do
      get("/admin").should route_to("admin/home#index")
    end

  end
end