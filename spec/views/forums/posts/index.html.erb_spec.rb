require 'spec_helper'

describe "forums/posts/index" do
  before(:each) do
    assign(:forums_posts, [
      stub_model(Forums::Post,
        :content => "Content"
      ),
      stub_model(Forums::Post,
        :content => "Content"
      )
    ])
  end

  it "renders a list of forums/posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Content".to_s, :count => 2
  end
end
