class OtpCode::OtpCodeGenerator
  def self.generate_otp_code
    rand(000_000..999_999).to_s.rjust(6, '0')
  end
end
