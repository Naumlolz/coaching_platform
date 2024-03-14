require "rails_helper"

RSpec.describe RestorePasswordJob, type: :job do
  let(:job_params) { { email: 'user@example.com', otp_code: '123456' } }

  describe '#perform' do
    it 'sends an email with the OTP code' do
      expect {
        described_class.perform_now(job_params)
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq([job_params[:email]])
      expect(mail.subject).to eq('Welcome to My Awesome Site')
      expect(mail.body.encoded).to match(job_params[:otp_code])
    end
  end
end
