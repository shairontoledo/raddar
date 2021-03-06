require 'spec_helper'

describe "venues/edit" do
  before(:each) do
    @venue = assign(:venue, stub_model(Venue,
      :name => "MyString",
      :description => "MyString",
      :address => "MyString",
      :city => "MyString"
    ))
  end

  it "renders the edit venue form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => venues_path(@venue), :method => "post" do
      assert_select "input#venue_name", :name => "venue[name]"
      assert_select "input#venue_description", :name => "venue[description]"
      assert_select "input#venue_address", :name => "venue[address]"
      assert_select "input#venue_city", :name => "venue[city]"
    end
  end
end
