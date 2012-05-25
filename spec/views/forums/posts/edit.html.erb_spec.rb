require 'spec_helper'

describe "forums/posts/edit" do
  before(:each) do
    @forums_post = assign(:forums_post, stub_model(Forums::Post,
      :content => "MyString"
    ))
  end

  it "renders the edit forums_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forums_posts_path(@forums_post), :method => "post" do
      assert_select "input#forums_post_content", :name => "forums_post[content]"
    end
  end
end
