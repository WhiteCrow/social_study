require 'spec_helper'

describe Microblog do
  let(:user) { create :user }
  let(:microblog) { create :microblog }
  let(:relay) { create :relay, relayable: microblog, user: user }

  context 'relay methods' do
    it 'relay by user' do
      lambda do
        user.relay(microblog)
      end.should change(microblog.relays, :size).by(1)
    end

    it 'unrelay by user' do
      microblog
      relay
      lambda do
        user.unrelay(microblog)
      end.should change(microblog.relays, :size).by(-1)
    end
  end
end
