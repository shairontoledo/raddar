require 'spec_helper'

describe "pubs/new" do
  before(:each) do
    assign(:pub, stub_model(Pub,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new pub form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pubs_path, :method => "post" do
      assert_select "input#pub_name", :name => "pub[name]"
      assert_select "input#pub_description", :name => "pub[description]"
    end
  end
end
