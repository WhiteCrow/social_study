require 'spec_helper'

describe UsersController do

  let(:user) { create :user }
  let(:admin) { create :admin }

  describe "authenticated" do
    before(:each) { sign_in user }

    it 'get current_user' do
      subject.send(:current_user).should eq user
    end

    describe "vote" do
      let(:knowledge) { create :knowledge }
      let(:note) { create :note, user: admin, knowledge: knowledge }
      before(:each) { note }

      #FIXME will fix routes bug
      #it 'useful' do
      #  expect {
      #    post :vote, {reputable_id: note.to_param, reputable_type: 'Note', vote_type: 'useful' }
      #  }.to change(admin.reputations.useful, :count).by(1)

      #  #cancel useful
      #  expect {
      #    post :vote, {reputable_id: note.to_param, reputable_type: 'Note', vote_type: 'useful' }
      #  }.to change(admin.reputations.useful, :count).by(-1)
      #end

      #it 'useless' do
      #  expect {
      #    post :vote, {reputable_id: note.to_param, reputable_type: 'Note', vote_type: 'useless' }
      #  }.to change(admin.reputations.useless, :count).by(1)

      #  #cancel useful
      #  expect {
      #    post :vote, {reputable_id: note.to_param, reputable_type: 'Note', vote_type: 'useless' }
      #  }.to change(admin.reputations.useless, :count).by(-1)
      #end

    end
  end
end
