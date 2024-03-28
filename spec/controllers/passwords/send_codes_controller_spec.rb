require 'rails_helper'

RSpec.describe Passwords::SendCodesController, type: :controller do
  let(:valid_email) { 'test@example.com' }
  let(:invalid_email) { 'invalid.email' }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'calls SendCodeService with correct email' do
        expect(Passwords::SendCodeService).to receive(:new).with(email: valid_email).and_return(double(perform: true))
        post :create, params: { email: valid_email }
        expect(response).to redirect_to(passwords_validate_code_path(email: valid_email))
        expect(flash[:success]).to eq('Code has been sent on your email')
      end
    end

    context 'with invalid parameters' do
      it 'renders the forget_password template' do
        post :create, params: { email: invalid_email }
        expect(response).to render_template('users/forget_password')
      end

      it 'sets an error flash message' do
        allow_any_instance_of(Passwords::SendCodeService).to receive(:perform).and_raise(ServiceError, 'Incorrect email input')
        post :create, params: { email: invalid_email }
        expect(flash.now[:error]).to eq('Incorrect email input')
      end
    end
  end
end
