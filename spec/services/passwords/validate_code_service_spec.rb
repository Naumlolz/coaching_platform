require 'rails_helper'

RSpec.describe Passwords::ValidateCodeService do
  let(:user_1) { create(:user,
                        reset_password_code: OtpCode::OtpCodeGenerator.generate_otp_code,
                        reset_password_code_sent_at: Time.zone.now) }
  let(:service_params) do
    {
      email: user_1.email,
      otp_code: user_1.reset_password_code
    }
  end

  subject { described_class.new(service_params) }

  describe '#perform' do
    it 'checks otp_code input, validity and if it belongs to desired user' do
      expect(subject).to receive(:check_not_nil_input)
      expect(subject).to receive(:check_otp_code_input)
      expect(subject).to receive(:check_otp_code_belongs_to_user)
      expect(subject).to receive(:check_otp_code_is_valid)
      subject.perform
    end
  end

  describe '#check_not_nil_input' do
    before do
      service_params[:otp_code] = ''
    end

    it 'raises error when email is nil' do
      expect{ subject.perform }.to raise_error(ServiceError, 'Cant be blank')
    end
  end

  describe '#check_otp_code_input' do
    context 'when otp_code input valid' do
      it 'should check otp_code input valid' do
        expect(service_params[:otp_code]).to match(/\A\d{6}\z/)
      end
    end

    context 'when otp_code input invalid' do
      before do
        service_params[:otp_code] = 'not_an_otp_code'
      end

      it 'should raise error' do
        expect{ subject.perform }.to raise_error(ServiceError, 'Incorrect otp_code input')
      end
    end
  end

  describe '#check_otp_code_belongs_to_user' do
    context 'with valid code' do
      it 'should check otp_code belongs to user' do
        expect(service_params[:otp_code]).to eq(user_1.reset_password_code)
      end
    end

    context 'with invalid code' do
      before do
        service_params[:otp_code] = '111111'
      end

      it 'should raise error when code invalid' do
        expect{ subject.perform }.to raise_error(ServiceError, 'Incorrect otp code')
      end
    end
  end

  describe '#check_otp_code_is_valid' do
    before do
      user_1.update(reset_password_code_sent_at: 10.minutes.ago(Time.zone.now))
    end

    it 'should raise error when code expired' do
      expect{ subject.perform }.to raise_error(ServiceError, 'Otp code expired')
    end
  end
end
