require "rails_helper"

RSpec.describe Coaches::UpdatePasswordService do
  let(:coach_1) { create(:coach, password: BCrypt::Password.create("1111")) }
  let(:service_params) do 
    {
      coach: coach_1,
      old_password: "1111",
      new_password: "12345",
      new_password_confirmation: "12345"
    }
  end

  example do
    expect(described_class).to equal(Coaches::UpdatePasswordService)
    expect(coach_1).to be_instance_of(Coach)
  end

  it 'should check old coaches password' do
    expect do
      described_class.new(
        service_params.merge(old_password: '123123123')
      ).call
    end.to raise_error(ServiceError, 'Password doesnt match')
  end

  it 'should check new coach password' do
    expect do
      described_class.new(
        service_params.merge(new_password: '123123123')
      ).call
    end.to raise_error(ServiceError, 'New password doesnt match')
  end

  it 'should update coach password' do
    coach_1.update(password: service_params[:new_password])
    expect(coach_1.password).to eq('12345')
  end
end
