require 'rails_helper'

RSpec.describe OtpCode::OtpCodeGenerator do
  describe '.generate_otp_code' do
    it 'should generate otp_code' do
      otp_code = OtpCode::OtpCodeGenerator.generate_otp_code
      expect(otp_code).to match(/\A\d{6}\z/)
    end
  end
end
