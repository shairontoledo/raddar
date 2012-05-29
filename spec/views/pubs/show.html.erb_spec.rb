require 'spec_helper'

describe "pubs/show" do
  before(:each) do
    @pub = assign(:pub, stub_model(Pub,
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
  end
end
