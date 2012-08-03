require "spec_helper"

describe Users::OmniauthCallbacksController do
  describe "routing" do

    [:facebook, :twitter].each do |provider|
      context "with #{provider} as provider" do

        it "routes to ##{provider}" do
          get("/users/auth/#{provider}/callback").should route_to("users/omniauth_callbacks##{provider}")
        end

        it "doesn't route to #passthru" do
          get("/users/auth/#{provider}").should route_to("users/omniauth_callbacks#passthru", provider: provider.to_s)
        end
      end

    end

  end
end