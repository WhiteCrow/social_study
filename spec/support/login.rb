#encoding: utf-8
module Login
  def self.included(spec)
    spec.class_eval do
      describe 'login' do
        let(:user) {Factory :user}

        before :each do
          user
          visit root_path
          fill_in '#user_email', with: 'user@example.com'
          fill_in '#user_password', with: 'password'
          click_button '登录'
          page.should have_content user.name
        end
      end
    end
  end
end
