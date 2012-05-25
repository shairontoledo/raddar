require 'spec_helper'

describe "forums/topics/index" do
  before(:each) do
    assign(:forums_topics, [
      stub_model(Forums::Topic,
        :title => "Title",
        :views => 1
      ),
      stub_model(Forums::Topic,
        :title => "Title",
        :views => 1
      )
    ])
  end

  it "renders a list of forums/topics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
