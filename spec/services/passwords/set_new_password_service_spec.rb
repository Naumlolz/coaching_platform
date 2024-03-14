require 'rails_helper'

RSpec.describe Passwords::SetNewPasswordService do
  let(:user_1) { create(:user, password: BCrypt::Password.create('1234')) }
  let(:service_params) do
    {
      email: user_1.email,
      new_password: BCrypt::Password.create('1111'),
      new_password_confirmation: '1111'
    }
  end

  subject { described_class.new(service_params) }

  describe '#perform' do
    it 'checks passwords input, sets user new password' do
      expect(subject).to receive(:check_not_nil_input)
      expect(subject).to receive(:check_password_inputs)
      expect(subject).to receive(:set_new_password)
      subject.perform
    end
  end

  describe '#check_not_nil_input' do
    before do
      service_params[:new_password] = ''
      service_params[:new_password_confirmation] = ''
    end

    it 'raises error when email is nil' do
      expect{ subject.perform }.to raise_error(ServiceError, 'Cant be blank')
    end
  end

  describe '#check_password_inputs' do
    before do
      service_params[:new_password] = '   1111'.strip!
      service_params[:new_password_confirmation] = '2222   '.strip!
    end

    it 'raises error when passwords doesnt match' do
      expect{ subject.perform }.to raise_error(ServiceError, 'Password confirmation must match password')
    end
  end

  describe '#set_new_password' do
    it 'should set new password for user' do
      expect(user_1.password).not_to eq(service_params[:new_password])

      user_1.update(password: service_params[:new_password])

      expect(user_1.password).to eq(service_params[:new_password])
    end
  end
end
