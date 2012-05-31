require 'spec_helper'

describe "universes/edit" do
  before(:each) do
    @universe = assign(:universe, stub_model(Universe,
      :name => "MyString"
    ))
  end

  it "renders the edit universe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => universes_path(@universe), :method => "post" do
      assert_select "input#universe_name", :name => "universe[name]"
    end
  end
end
