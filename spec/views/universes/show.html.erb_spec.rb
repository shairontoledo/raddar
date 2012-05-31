require 'spec_helper'

describe "universes/show" do
  before(:each) do
    @universe = assign(:universe, stub_model(Universe,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
