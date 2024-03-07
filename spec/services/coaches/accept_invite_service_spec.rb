require 'rails_helper'

RSpec.describe Coaches::AcceptInviteService do
  let(:coach_1) { create(:coach) }
  let(:invitation_1) { create(:users_coaches_invitation, coach_id: coach_1.id) }
  let(:service_params) do
    {
      coach_id: coach_1.id,
      invite_id: invitation_1.id
    }
  end

  describe '#call' do
    it 'should find and update invitation' do
      allow(UsersCoachesInvitation).to receive(:find_by).with(id: invitation_1.id).and_return(invitation_1)
      allow(invitation_1).to receive(:invalid?).and_return(false)
      allow(invitation_1).to receive(:update).with(accepted: true)
    end

    it 'should assign coach to user' do
      service = described_class.new(service_params).call

      expect(invitation_1.user.reload.coach_id).to eq(coach_1.id)
    end
  end
end
