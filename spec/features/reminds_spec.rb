# coding: utf-8
require 'spec_helper'

describe "reminds", type: :feature do
  include Login
  let(:admin) {create :admin}
  let(:microblog) { create :microblog, user: user }
  let(:comment) { create :comment, user: admin, commentable: microblog }

  it 'create comment by admin', js: true do
    microblog; comment
    user.unread_reminds.count.should eq 1
    visit '/'
    within '#remind-menu' do
      click_link user.unread_reminds.count.to_s
    end
    page.should have_content "微博 #{microblog.content} 有了新回复"

    within '#view-all-notice' do
      click_link '查看全部提醒'
    end
    current_path.should eq '/reminds'
    page.should have_content "微博 #{microblog.content} 有了新回复"

    within '#remind-menu' do
      page.should have_link '0'
    end
  end
end
