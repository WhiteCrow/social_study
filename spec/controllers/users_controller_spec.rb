require 'spec_helper'

describe UsersController do

  let(:user) { create :user }

  describe "authenticated" do
    before(:each) { sign_in user }
  end
end
