require 'rails_helper'

RSpec.describe Coaches::SignInService do
  let(:coach_1) { create(:coach, password: BCrypt::Password.create('1111')) }
  let(:service_params) do
    {
      email: coach_1.email,
      password: coach_1.password,
      session: {}
    }
  end
  subject { described_class.new(service_params) }

  describe '#perform' do
    it 'check coach validation, hashed password, creates session' do
      expect(subject).to receive(:check_coach_not_nil)
      expect(subject).to receive(:hashed_password)
      expect(subject).to receive(:create_session)
      expect(subject).to receive(:check_coach_validation)
      subject.perform
    end
  end

  describe '#fetch_coach' do
    it 'fetches coach from database' do
      expect(Coach).to receive(:find_by).with(email: service_params[:email]).and_return(coach_1)
      subject.send(:fetch_coach)
    end
  end

  describe '#check_coach_not_nil' do
    before do
      service_params[:email] = nil
    end

    it 'should return error when coach not exist' do
      expect{ subject.perform }.to raise_error(ServiceError, 'The client with this email or password is not found')
    end
  end

  describe '#hashed_password' do
    before do
      allow(subject).to receive(:fetch_coach).and_return(coach_1)
    end

    it 'should hash coaches password' do
      expect(subject.send(:hashed_password).to_s).to eq(BCrypt::Password.new(coach_1.password))
    end
  end

  describe '#create_session' do
    before do
      allow(subject).to receive(:hashed_password).and_return(coach_1.password)
      subject.send(:create_session)
    end

    it 'should create session for coach' do
      expect(subject.instance_variable_get(:@session)[:member_type]).to eq('Coach')
      expect(subject.instance_variable_get(:@session)[:member_id]).to eq(coach_1.id)
    end
  end
end
