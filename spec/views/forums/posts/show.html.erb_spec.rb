require 'spec_helper'

describe "forums/posts/show" do
  before(:each) do
    @forums_post = assign(:forums_post, stub_model(Forums::Post,
      :content => "Content"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Content/)
  end
end
