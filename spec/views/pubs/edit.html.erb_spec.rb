require 'spec_helper'

describe "pubs/edit" do
  before(:each) do
    @pub = assign(:pub, stub_model(Pub,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit pub form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pubs_path(@pub), :method => "post" do
      assert_select "input#pub_name", :name => "pub[name]"
      assert_select "input#pub_description", :name => "pub[description]"
    end
  end
end
