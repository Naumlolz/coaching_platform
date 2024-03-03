require 'rails_helper'

RSpec.describe Users::InviteCoachService do
  let(:user_1) { create(:user, :without_coach) }
  let(:coach_1) { create(:coach) }
  let(:coach_2) { create(:coach) }
  let(:service_params) do
    {
      user: user_1,
      coach_id: coach_1.id
    }
  end
  let(:empty_service_params) do 
    {
      user: nil,
      coach_id: nil
    }
  end

  describe '#check_coach_present' do
    it 'should raise error when have coach' do
      user_1.update(coach_id: coach_1.id)
      expect do
        described_class.new(service_params).call
      end.to raise_error(ServiceError, 'You already have coach')
    end
  end

  describe '#create_invitation' do
    it 'should create invitation' do
      expect(UsersCoachesInvitation.count).to eq(0)

      expect do
        described_class.new(service_params).call
      end.to change(UsersCoachesInvitation, :count).by(1)
    end
  end

  describe '#check_coach_counter' do
    it 'should not let you invite more than one coach' do
      create(:users_coaches_invitation, user: user_1, coach_id: coach_2.id, accepted: nil)
      expect do
        described_class.new(service_params).call
      end.to raise_error(ServiceError, "You can`t invite more than 1 coach")
    end
  end

  describe '#invitation_validation' do
    it 'should raise error' do
      expect do
        described_class.new(empty_service_params).call
      end.to raise_error(ServiceError, 'Could not invite')
    end
  end
end