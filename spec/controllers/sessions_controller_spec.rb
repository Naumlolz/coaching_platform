require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user_1) { create(:user) }
  let(:coach_1) { create(:coach) }

  describe 'POST #user_perform_sign_in' do
    context 'with valid credentials' do
      before do
        post :user_perform_sign_in, params: { email: user_1.email, password: 'password' }
      end

      it 'redirects to users_dashboard_path and sets a success flash message' do
        expect(response).to redirect_to(users_dashboard_path)
        expect(flash[:success]).to eq('Sign in is successfull!')
      end
    end

    context 'with invalid credentials' do
      before do
        post :user_perform_sign_in, params: { email: 'invalid@example.com', password: 'invalid' }
      end

      it 'renders the user_sign_in template' do
        expect(response).to render_template('user_sign_in')
      end

      it 'sets an error flash message' do
        expect(flash[:error]).to eq('The client with this email or password is not found')
      end
    end
  end

  describe 'POST #coach_perform_sign_in' do
    context 'with valid credentials' do
      before do
        post :coach_perform_sign_in, params: { email: coach_1.email, password: 'password' }
      end

      it 'redirects to coachs_dashboard_path and sets a success flash message' do
        expect(response).to redirect_to(coaches_dashboard_path)
        expect(flash[:success]).to eq('Sign in is successfull!')
      end
    end

    context 'with invalid credentials' do
      before do
        post :coach_perform_sign_in, params: { email: 'invalid@example.com', password: 'invalid' }
      end

      it 'renders the coach_sign_in template' do
        expect(response).to render_template('coach_sign_in')
      end

      it 'sets an error flash message' do
        expect(flash[:error]).to eq('The client with this email or password is not found')
      end
    end
  end

  describe 'POST #user_perform_sign_up' do
    context 'with valid parameters' do
      before do
        post :user_perform_sign_up, params: { 
          first_name: "John",
          last_name: "Doe",
          email: "john.doe@example.com",
          password: "password",
          password_confirmation: "password"
        }
      end

      it 'redirects to users_sign_in_path' do
        expect(response).to redirect_to(users_sign_in_path)
      end

      it 'sets a success flash message' do
        expect(flash[:success]).to eq('Thank you for signup! Now you can sign in!')
      end
    end

    context 'with invalid parameters' do
      before do
        post :user_perform_sign_up, params: {
          first_name: "John",
          last_name: "Doe",
          email: "john.doe@example.com",
          password: "password",
          password_confirmation: "invalid" # invalid password confirmation
        }
      end

      it 'renders the user_sign_up template' do
        expect(response).to render_template('user_sign_up')
      end

      it 'sets an error flash message' do
        expect(flash[:error]).to eq('The password doesnt match')
      end
    end
  end

  describe 'POST #coach_perform_sign_up' do
    context 'with valid parameters' do
      before do
        post :coach_perform_sign_up, params: { 
          first_name: "John",
          last_name: "Doe",
          email: "john.doe@example.com",
          password: "password",
          password_confirmation: "password"
        }
      end

      it 'redirects to coaches_sign_in_path' do
        expect(response).to redirect_to(coaches_sign_in_path)
      end

      it 'sets a success flash message' do
        expect(flash[:success]).to eq('Thank you for signup! Now you can sign in!')
      end
    end

    context 'with invalid parameters' do
      before do
        post :coach_perform_sign_up, params: {
          first_name: "John",
          last_name: "Doe",
          email: "john.doe@example.com",
          password: "password",
          password_confirmation: "invalid" # invalid password confirmation
        }
      end

      it 'renders the user_sign_up template' do
        expect(response).to render_template('coach_sign_up')
      end

      it 'sets an error flash message' do
        expect(flash[:error]).to eq('The password doesnt match')
      end
    end
  end

  describe 'GET #sign_out' do
    it 'clears the member type and member id from the session' do
      session[:member_type] = 'user'
      session[:member_id] = 1
      get :sign_out
      expect(session[:member_type]).to be_nil
      expect(session[:member_id]).to be_nil
    end

    it 'redirects to root_path' do
      get :sign_out
      expect(response).to redirect_to(root_path)
    end
  end
end
