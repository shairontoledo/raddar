require 'spec_helper'

describe "universes/index" do
  before(:each) do
    assign(:universes, [
      stub_model(Universe,
        :name => "Name"
      ),
      stub_model(Universe,
        :name => "Name"
      )
    ])
  end

  it "renders a list of universes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
