require 'spec_helper'

describe "forums/topics/edit" do
  before(:each) do
    @forums_topic = assign(:forums_topic, stub_model(Forums::Topic,
      :title => "MyString",
      :views => 1
    ))
  end

  it "renders the edit forums_topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forums_topics_path(@forums_topic), :method => "post" do
      assert_select "input#forums_topic_title", :name => "forums_topic[title]"
      assert_select "input#forums_topic_views", :name => "forums_topic[views]"
    end
  end
end
