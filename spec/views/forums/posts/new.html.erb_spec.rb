require 'spec_helper'

describe "forums/posts/new" do
  before(:each) do
    assign(:forums_post, stub_model(Forums::Post,
      :content => "MyString"
    ).as_new_record)
  end

  it "renders new forums_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forums_posts_path, :method => "post" do
      assert_select "input#forums_post_content", :name => "forums_post[content]"
    end
  end
end
