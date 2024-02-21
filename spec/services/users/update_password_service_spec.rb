require "rails_helper"

RSpec.describe Users::UpdatePasswordService do
  let(:user_1) { create(:user, password: BCrypt::Password.create("1111")) }
  let(:service_params) do 
    {
      user: user_1,
      old_password: "1111",
      new_password: "12345",
      new_password_confirmation: "12345"
    }
  end

  example do
    expect(described_class).to equal(Users::UpdatePasswordService)
  end

  it "should check old user`s password" do
    expect do
      described_class.new(
        service_params.merge(old_password: "1112")
      ).call
    end.to raise_error(ServiceError, "Password doesn`t match")
  end

  it 'should check new users password' do
    expect do
      described_class.new(
        service_params.merge(new_password: '77777')
      ).call
    end.to raise_error(ServiceError, 'New password doesnt match')
  end

  it 'should update users password' do
    user_1.update(password: service_params[:new_password])
    expect(user_1.password).to eq('12345')
  end
end
