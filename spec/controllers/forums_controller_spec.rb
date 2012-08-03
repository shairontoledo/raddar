require 'spec_helper'

describe ForumsController do

  before :each do
    @f = FactoryGirl.create :forum
  end
  
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all forums as @forums" do
      get :index, {}, valid_session
      assigns(:forums).should eq([@f])
    end
  end

  describe "GET show" do
    it "assigns the requested forum as @forum" do
      get :show, {:id => @f.to_param}, valid_session
      assigns(:forum).should eq(@f)
    end
  end

end
