require 'rails_helper'

RSpec.describe Passwords::SendCodeService do
  let(:user_1) { create(:user) }
  let(:service_params) do
    {
      email: user_1.email
    }
  end

  subject { described_class.new(service_params) }

  describe '#perform' do
    it 'checks email input and sends email with otp-code' do
      expect(subject).to receive(:check_not_nil_input)
      expect(subject).to receive(:remove_spaces)
      expect(subject).to receive(:check_email_input)
      expect(subject).to receive(:check_email_exists_in_db)
      expect(subject).to receive(:send_mail)
      subject.perform
    end
  end

  describe '#check_not_nil_input' do
    before do
      service_params[:email] = ''
    end

    it 'raises error when email is nil' do
      expect{ subject.perform }.to raise_error(ServiceError, 'Cant be blank')
    end
  end

  describe '#remove_spaces' do
    before do
      service_params[:email] = "   #{user_1.email}   "
    end

    it 'removes spaces from beginning and ending of the input' do
      subject.perform
      expect(service_params[:email]).to eq(user_1.email)
    end
  end

  describe '#check_email_input' do
    context 'when email input valid' do
      it 'should check email input valid' do
        expect(service_params[:email]).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      end
    end

    context 'when email input invalid' do
      before do
        service_params[:email] = 'not_an_email'
      end

      it 'should raise error' do
        expect{ subject.perform }.to raise_error(ServiceError, 'Incorrect email input')
      end
    end
  end

  describe '#check_email_exists_in_db' do
    before do
      service_params[:email] = "Yoloswaggins144@yandex.ru"
    end

    it 'should raise error if user not exist in db' do
      expect{ subject.perform }.to raise_error(ServiceError, 'User not existing')
    end
  end

  describe '#send_mail' do
    it 'should send email' do
      otp_code = OtpCode::OtpCodeGenerator.generate_otp_code
      allow(subject).to receive(:generate_otp_code).and_return(otp_code)

      expect(RestorePasswordJob).to receive(:perform_now).with(
        email: service_params[:email], otp_code: otp_code
      )

      expect(user_1.reset_password_code).to be_nil
      subject.send(:send_mail)
      user_1.reload
      expect(user_1.reset_password_code).to eq(otp_code)
    end
  end
end
