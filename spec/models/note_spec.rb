require 'spec_helper'

describe Note do
  let(:user) { create :user }

  describe 'scope' do
    let(:tom) { create :user }
    let(:jack) { create :user }
    let(:note_hotter) { create :note }
    let(:note) { create :note }
    let(:note_useless) { create :note }
    let(:reputation_1) { create :reputation, reputable: note, user: jack }
    let(:reputation_2) { create :reputation, reputable: note_hotter, user: jack}
    let(:reputation_3) { create :reputation, reputable: note_hotter, user: tom}

    it 'top' do
      note; note_hotter; note_useless; reputation_1; reputation_2; reputation_3
      top_notes = Note.top
      top_notes[0].reputations.count.should eq 2
      top_notes[1].reputations.count.should eq 1
      top_notes[2].reputations.count.should eq 0
    end
  end
end
