require 'spec_helper'

describe "forums/topics/show" do
  before(:each) do
    @forums_topic = assign(:forums_topic, stub_model(Forums::Topic,
      :title => "Title",
      :views => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/1/)
  end
end
