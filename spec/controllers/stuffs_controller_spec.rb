require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe StuffsController do

  # This should return the minimal set of attributes required to create a valid
  # Stuff. As you add validations to Stuff, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StuffsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all stuffs as @stuffs" do
      stuff = Stuff.create! valid_attributes
      get :index, {}, valid_session
      assigns(:stuffs).should eq([stuff])
    end
  end

  describe "GET show" do
    it "assigns the requested stuff as @stuff" do
      stuff = Stuff.create! valid_attributes
      get :show, {:id => stuff.to_param}, valid_session
      assigns(:stuff).should eq(stuff)
    end
  end

  describe "GET new" do
    it "assigns a new stuff as @stuff" do
      get :new, {}, valid_session
      assigns(:stuff).should be_a_new(Stuff)
    end
  end

  describe "GET edit" do
    it "assigns the requested stuff as @stuff" do
      stuff = Stuff.create! valid_attributes
      get :edit, {:id => stuff.to_param}, valid_session
      assigns(:stuff).should eq(stuff)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Stuff" do
        expect {
          post :create, {:stuff => valid_attributes}, valid_session
        }.to change(Stuff, :count).by(1)
      end

      it "assigns a newly created stuff as @stuff" do
        post :create, {:stuff => valid_attributes}, valid_session
        assigns(:stuff).should be_a(Stuff)
        assigns(:stuff).should be_persisted
      end

      it "redirects to the created stuff" do
        post :create, {:stuff => valid_attributes}, valid_session
        response.should redirect_to(Stuff.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved stuff as @stuff" do
        # Trigger the behavior that occurs when invalid params are submitted
        Stuff.any_instance.stub(:save).and_return(false)
        post :create, {:stuff => {}}, valid_session
        assigns(:stuff).should be_a_new(Stuff)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Stuff.any_instance.stub(:save).and_return(false)
        post :create, {:stuff => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested stuff" do
        stuff = Stuff.create! valid_attributes
        # Assuming there are no other stuffs in the database, this
        # specifies that the Stuff created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Stuff.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => stuff.to_param, :stuff => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested stuff as @stuff" do
        stuff = Stuff.create! valid_attributes
        put :update, {:id => stuff.to_param, :stuff => valid_attributes}, valid_session
        assigns(:stuff).should eq(stuff)
      end

      it "redirects to the stuff" do
        stuff = Stuff.create! valid_attributes
        put :update, {:id => stuff.to_param, :stuff => valid_attributes}, valid_session
        response.should redirect_to(stuff)
      end
    end

    describe "with invalid params" do
      it "assigns the stuff as @stuff" do
        stuff = Stuff.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Stuff.any_instance.stub(:save).and_return(false)
        put :update, {:id => stuff.to_param, :stuff => {}}, valid_session
        assigns(:stuff).should eq(stuff)
      end

      it "re-renders the 'edit' template" do
        stuff = Stuff.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Stuff.any_instance.stub(:save).and_return(false)
        put :update, {:id => stuff.to_param, :stuff => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested stuff" do
      stuff = Stuff.create! valid_attributes
      expect {
        delete :destroy, {:id => stuff.to_param}, valid_session
      }.to change(Stuff, :count).by(-1)
    end

    it "redirects to the stuffs list" do
      stuff = Stuff.create! valid_attributes
      delete :destroy, {:id => stuff.to_param}, valid_session
      response.should redirect_to(stuffs_url)
    end
  end

end