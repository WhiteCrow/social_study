require 'spec_helper'

describe Entry do
  let(:entry) { create :entry }

  it 'parse entry content' do
    entry.update_attributes(content: "Good[[test]]Yes")
    entry.content.should eq "Good<a class=\"entry-title\">test</a>Yes"

    entry_2 = Entry.create!({title: 'entry_2', content: 'Good[[]]Yes[[]]'})
    entry_2.content.should eq "Good Yes "

    entry_3 = Entry.create!({title: 'entry_3', content: 'Good[[No]]Yes[[Great]]'})
    entry_3.content.should eq "Good<a class=\"entry-title\">No</a>Yes<a class=\"entry-title\">Great</a>"
  end
end
