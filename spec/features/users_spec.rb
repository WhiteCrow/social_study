require 'spec_helper'
describe "User page", type: :feature do
  include Login

  it "describe himself", js: true do
    visit "/users/#{user.id}"
    within "#user-describe" do
      page.should have_content "请编辑个人简介"
      page.should_not have_selector "form"
      click_link "编辑"
      page.should have_selector "form"
      page.should_not have_content "编辑"
      fill_in 'user_description', with: '这是我的个人简介'
      click_button '提交'
      page.should have_content "编辑"
      page.should have_content '这是我的个人简介'
    end
  end

  it "cancel describe", js: true do
    visit "/users/#{user.id}"
    within "#user-describe" do
      page.should have_content "请编辑个人简介"
      page.should_not have_selector "form"
      click_link "编辑"
      page.should have_selector "form"
      page.should_not have_content "编辑"
      fill_in 'user_description', with: '这是我的个人简介'
      click_link '取消'
      page.should have_content "编辑"
      page.should have_content '请编辑个人简介'
    end
  end
end
