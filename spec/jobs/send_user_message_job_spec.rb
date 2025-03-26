require 'rails_helper'

RSpec.describe SendUserMessageJob, type: :job do
  let!(:user) { create(:user, id: 1) }
  let!(:coach) { create(:coach, id: 2) }
  let(:message_params) do
    {
      body: 'Test message',
      user_id: user.id,
      coach_id: coach.id
    }
  end

  before do
    ActiveJob::Base.queue_adapter = :test
    allow(ActionCable.server).to receive(:broadcast)
  end

  describe '#perform' do
    it 'broadcasts message' do
      chat_id = [message_params[:user_id], message_params[:coach_id]].sort.join
      expect(ActionCable.server).to receive(:broadcast)
        .with("message_channel_#{chat_id}", { html: "<p>#{message_params[:body]}</p>" })

      described_class.new.perform(message_params)
    end

    it 'can be enqueued' do
      expect {
        described_class.perform_later(message_params)
      }.to have_enqueued_job(described_class).with(message_params)
    end
  end
end
