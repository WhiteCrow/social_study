require 'spec_helper'

describe Entry do
  let(:user) { create :user }
  let(:entry) { create :entry }

  it 'parse entry content' do
    entry.update_attributes(content: "Good[[test]]Yes")
    entry.parsed_content.should eq "Good<a class=\"entry-title\" ng-click=\"next('test')\">test</a>Yes"

    entry_2 = Entry.create!({title: 'entry_2', content: 'Good[[]]Yes[[]]', user_id: user.id})
    entry_2.parsed_content.should eq "Good Yes "

    entry_3 = Entry.create!({title: 'entry_3', content: 'Good[[No]]Yes[[Great]]', user_id: user.id})
    entry_3.parsed_content.should eq "Good<a class=\"entry-title\" ng-click=\"next('No')\">No</a>Yes<a class=\"entry-title\" ng-click=\"next('Great')\">Great</a>"
  end

  it 'cannot create entry by title reserved if type is nil' do
    word = Entry::RESERVED_TITLES.first
    init_count = Entry.count
    begin
      Entry.create!({title: word, content: 'content', user_id: user.id})
    rescue Mongoid::Errors::Validations
    end
    Entry.count.should eq init_count
  end

  it 'can create entry by title reserved if type is not nil' do
    word = Entry::RESERVED_TITLES.first
    init_count = Entry.count
    Entry.create!({title: word, content: 'content', type: 'menu', user_id: user.id})
    Entry.count.should eq (init_count + 1)
  end
end
