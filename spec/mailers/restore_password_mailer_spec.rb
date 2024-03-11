require "rails_helper"

RSpec.describe RestorePasswordMailer, type: :mailer do
  let(:user_1) { create(:user) }
  let(:otp_code) { '123456' }
  let(:mail) { 
    described_class.with(
                          email: user_1.email, otp_code: otp_code
                        ).send_otp_code.deliver_now 
  }

  describe '#send_otp_code' do
    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to My Awesome Site')
      expect(mail.to).to eq([user_1.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(otp_code)
    end
  end
end
