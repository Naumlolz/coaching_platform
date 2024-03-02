require 'rails_helper'

RSpec.describe Coaches::CreateMessageService do
  let(:coach_1) { create(:coach) }
  let(:user_1) { create(:user, coach_id: coach_1.id) }
  let(:service_params) do
    {
      user_id: user_1.id,
      coach_id: coach_1.id,
      body: 'message_body',
      sent_by_coach: true
    }
  end
  let(:empty_service_params) do 
    {
      user_id: nil,
      coach_id: nil,
      body: nil,
      sent_by_coach: nil
    }
  end

  describe '#create_message' do
    it 'should create message' do
      expect(Message.count).to eq(0)

      expect do
        described_class.new(service_params).perform
      end.to change(Message, :count).by(1)
    end
  end

  describe '#message_validation' do
    it 'should return error when message is invalid' do
      expect do
        described_class.new(empty_service_params).perform
      end.to raise_error(ServiceError, 'Message is not valid')
    end
  end
end
