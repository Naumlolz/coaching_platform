require 'rails_helper'

RSpec.describe Users::SignUpService do
  let(:user_1) { create(:user) }
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

  it 'should create user' do
    expect(User.count).to eq(0)

    described_class.new(service_params).perform

    expect(User.count).to eq(1)
    created_user = User.first
    expect(created_user.first_name).to eq('Yolo')
  end

  it 'fails when user exists' do
    expect do
      described_class.new(
        service_params.merge(email: user_1.email)
      ).perform
    end.to raise_error(ServiceError, 'This email is already taken')
  end

  it 'fails when password doesnt match' do
    expect do
      described_class.new(
        service_params.merge(password: '1111')
      ).perform
    end.to raise_error(ServiceError, 'The password doesnt match')
  end

  it 'fails when user is invalid' do
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
