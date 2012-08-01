require "spec_helper"

describe ContactsController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/contacts").should_not be_routable
    end

    it "routes to #new" do
      get("/contacts/new").should route_to("contacts#new")
    end

    it "doesn't route to #show" do
      get("/contacts/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/contacts/1/edit").should_not be_routable
    end

    it "routes to #create" do
      post("/contacts").should route_to('contacts#create')
    end

    it "doesn't route to #update" do
      put("/contacts/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/contacts/1").should_not be_routable
    end

  end
end
