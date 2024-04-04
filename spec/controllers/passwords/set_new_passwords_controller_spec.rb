require 'rails_helper'

RSpec.describe Passwords::SetNewPasswordsController, type: :controller do
  let(:user_1) { create(:user, password: BCrypt::Password.create('1111')) }
  let(:new_password) { '1234' }
  let(:new_password_confirmation) { '1234' }

  describe 'GET #show' do
    it 'should show set new password template' do
      get :show, params: { email: user_1.email }
      expect(response).to render_template('passwords/set_new_passwords/show')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'calls Passwords::SetNewPasswordsController with correct data' do
        expect(Passwords::SetNewPasswordService).to receive(:new).with(
          email: user_1.email,
          new_password: new_password,
          new_password_confirmation: new_password_confirmation
        ).and_return(double(perform: true))

        post :create, params: { email: user_1.email, new_password: new_password, new_password_confirmation: new_password_confirmation }

        expect(flash.now[:success]).to eq('Password was successfully changed')
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'with incorrect data' do
      it 'renders the set_new_passwords template' do
        post :create, params: { new_password: '',  new_password_confirmation: '' }
        expect(response).to render_template('passwords/set_new_passwords/show')
      end

      it 'shows flash error message' do
        allow_any_instance_of(Passwords::SetNewPasswordService).to receive(:perform).and_raise(ServiceError, 'Cant be blank')
        post :create, params: { new_password: '',  new_password_confirmation: '' }
        expect(flash.now[:error]).to eq('Cant be blank')
      end
    end
  end
end
