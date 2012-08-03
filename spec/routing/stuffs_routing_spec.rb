require "spec_helper"

describe StuffsController do
  describe "routing" do

    it "doesn't route to #index" do
      get("/stuffs").should_not be_routable
    end

    it "doesn't route to #new" do
      get("/stuffs/new").should_not be_routable
    end

    it "doesn't route to #show" do
      get("/stuffs/1").should_not be_routable
    end

    it "doesn't route to #edit" do
      get("/stuffs/1/edit").should_not be_routable
    end

    it "doesn't route to #create" do
      post("/stuffs").should_not be_routable
    end

    it "doesn't route to #update" do
      put("/stuffs/1").should_not be_routable
    end

    it "doesn't route to #destroy" do
      delete("/stuffs/1").should_not be_routable
    end

    context 'nested with pub' do

      it "doesn't route to #index" do
        get("/pubs/pub-name/stuffs").should_not be_routable
      end

      it "routes to #new" do
        get("/pubs/pub-name/stuffs/new").should route_to("stuffs#new", pub_id: 'pub-name')
      end

      it "routes to #show" do
        get("/pubs/pub-name/stuffs/1").should route_to("stuffs#show", :id => "1", pub_id: 'pub-name')
      end

      it "routes to #edit" do
        get("/pubs/pub-name/stuffs/1/edit").should route_to("stuffs#edit", :id => "1", pub_id: 'pub-name')
      end

      it "routes to #create" do
        post("/pubs/pub-name/stuffs").should route_to("stuffs#create", pub_id: 'pub-name')
      end

      it "routes to #update" do
        put("/pubs/pub-name/stuffs/1").should route_to("stuffs#update", :id => "1", pub_id: 'pub-name')
      end

      it "routes to #destroy" do
        delete("/pubs/pub-name/stuffs/1").should route_to("stuffs#destroy", :id => "1", pub_id: 'pub-name')
      end
    end
  end
end
