require 'rails_helper'

RSpec.describe Users::SignInService do
  let(:user_1) { create(:user, password: BCrypt::Password.create("1111")) }
  let(:session) { { user_id: nil, member_type: nil } }
  let(:service_params) do
    {
      email: user_1.email,
      password: user_1.password,
      session: session
    }
  end

  it 'should fetch user' do
    email = service_params[:email]

    # expect(User).to receive(:find_by).with(email: email).and_return(user_1)
    expect(User.find_by(email: email)).to eq user_1
  end
end