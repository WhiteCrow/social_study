# coding: utf-8
require 'spec_helper'

describe "Account management" do
  it 'sign up' do
    visit '/account/sign_up' do
      fill_in '昵称', with: 'nickname'
      fill_in '邮箱', with: 'user@example.com'
      fill_in '密码', with: 'password'
      fill_in '确认密码', with: 'password'
      click_button '注册'
      current_url.should_be eq(root_path)
      current_page.should_be have_content('有什么想告诉大家')
    end
  end
end
