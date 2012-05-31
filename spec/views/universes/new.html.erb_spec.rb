require 'spec_helper'

describe "universes/new" do
  before(:each) do
    assign(:universe, stub_model(Universe,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new universe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => universes_path, :method => "post" do
      assert_select "input#universe_name", :name => "universe[name]"
    end
  end
end
