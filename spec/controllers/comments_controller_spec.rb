require 'spec_helper'

describe CommentsController do

  def valid_session
    {}
  end

  def valid_attributes
    {content: 'a content'}
  end



  describe "POST create" do
    describe "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {:comment => valid_attributes}, valid_session
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, {:comment => valid_attributes}, valid_session
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

      it "redirects to the created comment" do
        post :create, {:comment => valid_attributes}, valid_session
        response.should redirect_to(Comment.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {:comment => {}}, valid_session
        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {:comment => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      #@comment = FactoryGirl.create :comment
    end

    it "destroys the requested comment" do
      comment = FactoryGirl.create :comment
      expect {
        delete :destroy, {:id => comment.to_param, :"#{comment.commentable.class.to_s.underscore}_id" => comment.commentable.to_param}, valid_session
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the commentable" do
      comment = FactoryGirl.create :comment
      delete :destroy, {:id => comment.to_param}, valid_session
      response.should redirect_to(raddar_path(comment.commentable))
    end
  end
end
