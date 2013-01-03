require 'spec_helper'

describe "knowledges/new" do
  before(:each) do
    assign(:knowledge, stub_model(Knowledge,
      :title => "MyString",
      :second_title => "MyString",
      :description => "MyText",
      :knowledge_association_id => 1
    ).as_new_record)
  end

  it "renders new knowledge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => knowledges_path, :method => "post" do
      assert_select "input#knowledge_title", :name => "knowledge[title]"
      assert_select "input#knowledge_second_title", :name => "knowledge[second_title]"
      assert_select "textarea#knowledge_description", :name => "knowledge[description]"
      assert_select "input#knowledge_knowledge_association_id", :name => "knowledge[knowledge_association_id]"
    end
  end
end
