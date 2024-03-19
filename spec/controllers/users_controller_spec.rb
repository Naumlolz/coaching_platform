require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user
  let(:user_1) { create(:user) }
  let(:coach_1) { create(:coach) }
  let(:coach_2) { create(:coach) }

  before(:each) do
    session[:member_id] = user_1.id
  end

  describe 'GET #dashboard' do
    context 'when age is blank' do
      before do
        user_1.update(age: nil)
      end

      it 'should redirect to finish profile page' do
        get :dashboard

        expect(response).to redirect_to(users_finish_profile_path)
      end
    end

    context 'when age is present' do
      it 'should allow user to get dashboard' do
        get :dashboard

        expect(response).not_to redirect_to(users_finish_profile_path)
      end
    end
  end

  describe 'POST #finish_user_profile' do
    let(:action_params) do
      {
        age: rand(100),
        gender: 'female',
        description: 'new user desription'
      }
    end

    it 'updates user profile and redirects to dashboard' do
      post :finish_user_profile, params: { 
        age: action_params[:age], 
        gender: action_params[:gender], 
        description: action_params[:description] 
      }

      user_1.reload

      expect(user_1.age).to eq(action_params[:age])
      expect(user_1.gender).to eq(action_params[:gender])
      expect(user_1.description).to eq(action_params[:description])
      expect(response).to redirect_to(users_dashboard_path)
    end
  end

  describe 'POST #update_profile' do
    context 'when params are valid' do
      let(:valid_action_params) do
        {
          first_name: 'Leonidas',
          last_name: 'Da Silva',
          age: rand(5..99)
        }
      end

      it 'updates user profile and redirects to profile path' do
        patch :update_profile, params: { user: valid_action_params }

        expect(response).to redirect_to(users_profile_path)
        expect(flash[:success]).to eq('Your profile was updated')
      end
    end

    context 'when params are invalid' do
      let(:invalid_action_params) do
        {
          first_name: '',
          last_name: '',
          age: nil
        }
      end

      it 'renders profile template with errors' do
        patch :update_profile, params: { user: invalid_action_params }

        expect(response).to render_template('profile')
        expect(assigns(:errors)).to be_present
      end
    end
  end

  describe 'user_params' do
    it "permits specific attributes" do
      params = ActionController::Parameters.new(user: { first_name: 'John', last_name: 'Doe', age: 25, avatar: 'avatar.jpg' })
      allow(controller).to receive(:params).and_return(params)

      expect(controller.send(:user_params)).to eq({ "first_name" => "John", "last_name" => "Doe", "age" => 25, "avatar" => "avatar.jpg" })
    end
  end

  describe 'PATCH #update_password' do
    context 'when valid params are provided' do
      let(:valid_action_params) do
        {
          user: user_1,
          old_password: 'example_password',
          new_password: '1234',
          new_password_confirmation: '1234'
        }
      end

      it 'updates user password and redirects to dashboard' do

        patch :update_password, params: valid_action_params

        expect(response).to redirect_to(users_dashboard_path)
      end
    end
  end

  describe 'GET #all_coaches' do
    before do
      user_1.update(coach_id: coach_1.id)
    end

    it 'shows all coaches and current coach' do
      get :all_coaches
      current_coach = user_1.coach
      expect(Coach.count).to eq(Coach.all.ids.count)
      expect(current_coach.id).to eq(coach_1.id)
    end
  end

  describe 'POST #invite_coach' do
    let(:valid_action_params) do
      {
        user: user_1,
        coach_id: coach_1.id
      }
    end

    before do
      user_1.update(coach_id: nil)
    end

    it 'invites coach and redirects to users dashboard' do
      post :invite_coach, params: valid_action_params

      expect(flash[:success]).to eq('You`ve successfully sent invitation')
      expect(response).to redirect_to(users_dashboard_path)
    end
  end

  describe 'POST #unassign_coach' do
    it 'removes coach from user' do
      post :unassign_coach

      current_user = user_1
      current_user.update(coach_id: nil)
      expect(user_1.coach_id).to be_nil
      expect(response).to redirect_to(users_all_coaches_path)
    end
  end
end
