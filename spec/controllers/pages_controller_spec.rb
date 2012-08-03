require 'spec_helper'

describe PagesController do
  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested page as @page" do
      page = FactoryGirl.create :page
      get :show, {:id => page.to_param}, valid_session
      assigns(:page).should eq(page)
    end
  end

end
