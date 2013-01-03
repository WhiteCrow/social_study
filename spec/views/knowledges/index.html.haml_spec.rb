require 'spec_helper'

describe "knowledges/index" do
  before(:each) do
    assign(:knowledges, [
      stub_model(Knowledge,
        :title => "Title",
        :second_title => "Second Title",
        :description => "MyText",
        :knowledge_association_id => 1
      ),
      stub_model(Knowledge,
        :title => "Title",
        :second_title => "Second Title",
        :description => "MyText",
        :knowledge_association_id => 1
      )
    ])
  end

  it "renders a list of knowledges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Second Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
