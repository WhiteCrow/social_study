#encoding: utf-8
module Login
  def self.included(spec)
    spec.class_eval do
      let(:user) {create :user}

      before :each do
        user
        visit '/'
        within '#sign_in' do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: 'password'
          click_button '登录'
        end
        page.should have_content user.name
      end
    end
  end
end
