require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"

  let(:jack) { FactoryGirl.create(:user) }
  let(:tom) { FactoryGirl.create(:user) }

  it 'follow features' do
    jack.following.count.should eq 0
    tom.followers.count.should  eq 0

    jack.can_follow?(tom).should be_true
    jack.follow(tom)

    jack.following.count.should eq 1
    tom.followers.count.should  eq 1
    jack.followed?(tom).should be_true

    jack.unfollow(tom)
    jack.followed?(tom).should be_false

    jack.following.count.should eq 0
    tom.followers.count.should  eq 0
  end
end
