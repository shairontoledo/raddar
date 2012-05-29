require 'spec_helper'

describe "stuffs/edit" do
  before(:each) do
    @stuff = assign(:stuff, stub_model(Stuff,
      :name => "MyString",
      :content => "MyString"
    ))
  end

  it "renders the edit stuff form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stuffs_path(@stuff), :method => "post" do
      assert_select "input#stuff_name", :name => "stuff[name]"
      assert_select "input#stuff_content", :name => "stuff[content]"
    end
  end
end
