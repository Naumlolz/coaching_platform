require 'rails_helper'

RSpec.describe Passwords::ValidateCodesController, type: :controller do
  let(:user_1) { create(:user, :with_otp_code) }

  describe 'GET #show' do
    it 'should show validate code' do
      get :show, params: { email: user_1.email }
      expect(response).to render_template('passwords/validate_codes/show')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'calls Passwords::ValidateCodeService with correct email' do
        expect(Passwords::ValidateCodeService).to receive(:new).with(
          email: user_1.email,
          otp_code: user_1.reset_password_code
        ).and_return(double(perform: true))

        post :create, params: { email: user_1.email, otp_code: user_1.reset_password_code }
        expect(response).to redirect_to(passwords_set_new_password_path(email: user_1.email))
      end
    end

    context 'with invalide params' do
      it 'renders the validate_codes template' do
        post :create, params: { otp_code: '' }
        expect(response).to render_template('passwords/validate_codes/show')
      end

      it 'shows flash error message' do
        allow_any_instance_of(Passwords::ValidateCodeService).to receive(:perform).and_raise(ServiceError, 'Incorrect otp code')
        post :create, params: { otp_code: '123456' }
        expect(flash.now[:error]).to eq('Incorrect otp code')
      end
    end
  end
end
