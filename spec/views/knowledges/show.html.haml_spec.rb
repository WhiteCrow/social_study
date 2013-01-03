require 'spec_helper'

describe "knowledges/show" do
  before(:each) do
    @knowledge = assign(:knowledge, stub_model(Knowledge,
      :title => "Title",
      :second_title => "Second Title",
      :description => "MyText",
      :knowledge_association_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Second Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
