require 'spec_helper'

describe "RailsAdmin", type: :feature do
  include Login

  it 'can not access /admin page' do
    visit "/admin"
    current_path.should eq '/'
  end
end
