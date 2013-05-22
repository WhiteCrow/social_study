require 'spec_helper'

describe Note do
  let(:user) { create :user }

  describe 'scope' do
    let(:tom) { create :user }
    let(:jack) { create :user }
    let(:experience_hotter) { create :experience }
    let(:experience) { create :experience }
    let(:experience_useless) { create :experience }
    let(:reputation_1) { create :reputation, reputable: experience, user: jack }
    let(:reputation_2) { create :reputation, reputable: experience_hotter, user: jack}
    let(:reputation_3) { create :reputation, reputable: experience_hotter, user: tom}

    it 'top' do
      experience; experience_hotter; experience_useless; reputation_1; reputation_2; reputation_3

      experience.reputations.count.should eq 1
      experience_hotter.reputations.count.should eq 2
      experience_useless.reputations.count.should eq 0

      top_experiences = Experience.top

      top_experiences[0].reputations.count.should eq 2
      top_experiences[1].reputations.count.should eq 1
      top_experiences[2].reputations.count.should eq 0
    end
  end
end
