require 'rails_helper'

RSpec.describe Coaches::SignUpService do
  let(:coach_1) { create(:coach) }
  let(:service_params) do
    {
      first_name: "Yolo",
      last_name: "Swaggins",
      email: "yolo@swaggins.com",
      password: "1234",
      password_confirmation: "1234"
    }
  end
  let(:empty_service_params) do 
    {
      first_name: "",
      last_name: "",
      email: "",
      password: "",
      password_confirmation: ""
    }
  end

  it 'should create coach' do
    expect(Coach.count).to eq(0)
    described_class.new(service_params).perform

    expect(Coach.count).to eq(1)
    created_coach = Coach.first
    expect(created_coach.first_name).to eq('Yolo')
  end

  it 'fails when coach exists' do
    expect do
      described_class.new(
        service_params.merge(email: coach_1.email)
      ).perform
    end.to raise_error(ServiceError, 'This email is already taken')
  end

  it 'fails if password doesnt match' do
    expect do
      described_class.new(
        service_params.merge(password: '13456')
      ).perform
    end.to raise_error(ServiceError, 'The password doesnt match')
  end

  it 'fails when coach is invalid' do
    expect do
      described_class.new(empty_service_params).perform
    end.to raise_error(ServiceError) do |error|
      expect(error.message).to include("First name can't be blank")
      expect(error.message).to include("Last name can't be blank")
      expect(error.message).to include("Email can't be blank")
      expect(error.message).to include("Password can't be blank")
      expect(error.message).to include("Email is invalid")
    end
  end
end
