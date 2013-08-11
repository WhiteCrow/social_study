# coding: utf-8
require 'spec_helper'

describe "Account management", type: :feature do
  let(:user) { create :user }

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

  it 'sign in' do
    user
    visit '/account/sign_in' do
      fill_in '邮箱', with: user.email
      fill_in '密码', with: 'password'
      click_button '登录'
      current_url.should_be eq(root_path)
      current_page.should_be have_content('有什么想告诉大家')
    end
  end

  describe 'eidt' do
    include Login

    it 'edit user name and password' do
      visit '/account/edit'
      page.should have_content '账户设置'
      within '#edit_user' do
        fill_in 'user_name', with: 'Great user'
        fill_in 'user_current_password', with: 'password'
        fill_in 'user_password', with: 'greatpassword'
        fill_in 'user_password_confirmation', with: 'greatpassword'
        click_button '提交'
      end

      current_path.should eq '/'
      user.reload.name.should eq 'Great user'
    end

    it 'only edit user name' do
      visit '/account/edit'
      within '#edit_user' do
        fill_in 'user_name', with: 'Good user'
        fill_in 'user_current_password', with: 'password'
        click_button '提交'
      end
      current_path.should eq '/'
      user.reload.name.should eq 'Good user'
    end
  end

end
