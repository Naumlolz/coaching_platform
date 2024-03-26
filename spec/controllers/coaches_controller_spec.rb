require 'rails_helper'

RSpec.describe CoachesController, type: :controller do
  login_coach
  let(:coach_1) { create(:coach) }
  let(:user_1) { create(:user, coach_id: coach_1.id)}
  let(:user_2) { create(:user, coach_id: coach_1.id)}
  let(:user_coach_invitation_1) { create(:users_coaches_invitation, 
      user_id: user_1.id,
      coach_id: coach_1.id
    )
  }
  let(:user_coach_invitation_2) { create(:users_coaches_invitation, 
    user_id: user_2.id,
    coach_id: coach_1.id
    )
  }

  before(:each) do
    session[:member_id] = coach_1.id
  end

  describe 'GET #dashboard' do
    context 'when age is blank' do
      before do
        coach_1.update(age: nil)
      end

      it 'should redirect to finish profile page' do
        get :dashboard

        expect(response).to redirect_to(coaches_finish_profile_path)
      end
    end

    context 'when age is present' do
      it 'should allow user to get dashboard' do
        get :dashboard

        expect(response).not_to redirect_to(coaches_finish_profile_path)
      end
    end
  end

  describe 'POST #finish_coach_profile' do
    let(:action_params) do
      {
        age: rand(100),
        gender: 'female',
        description: 'new user desription',
        education: 'education',
        experience: 'expirience',
        certificate: 'certificate'
      }
    end

    it 'updates coach profile and redirects to dashboard' do
      post :finish_coach_profile, params: { 
        age: action_params[:age], 
        gender: action_params[:gender], 
        description: action_params[:description],
        education: action_params[:education],
        experience: action_params[:experience],
        certificate: action_params[:certificate]
      }

      coach_1.reload

      expect(coach_1.age).to eq(action_params[:age])
      expect(coach_1.gender).to eq(action_params[:gender])
      expect(coach_1.description).to eq(action_params[:description])
      expect(coach_1.education).to eq(action_params[:education])
      expect(coach_1.experience).to eq(action_params[:experience])
      expect(coach_1.certificate).to eq(action_params[:certificate])
      expect(response).to redirect_to(coaches_dashboard_path)
    end
  end

  describe 'PATCH #update_expertise' do
    let(:program1) { create(:program) }
    let(:program2) { create(:program) }

    before do
      allow(controller).to receive(:current_coach).and_return(coach_1)
    end

    it 'calls UpdateExpertiseService and redirects to coaches_profile_path' do
      program_ids = [program1.id, program2.id]
      update_expertise_service = instance_double(Coaches::UpdateExpertiseService, perform: true)
      allow(Coaches::UpdateExpertiseService).to receive(:new).and_return(update_expertise_service)

      patch :update_expertise, params: { coach: { program_ids: program_ids } }

      expect(response).to redirect_to(coaches_profile_path)
      expect(Coaches::UpdateExpertiseService).to have_received(:new).with(coach_id: coach_1.id, program_ids: program_ids.map(&:to_s))
      expect(update_expertise_service).to have_received(:perform)
    end
  end

  describe 'POST #update_profile' do
    context 'when params are valid' do
      let(:valid_action_params) do
        {
          first_name: 'Leonidas',
          last_name: 'Da Silva',
          age: rand(5..99),
          education: 'new_education',
          experience: 'new_expirience',
          certificate: 'new_certificate'
        }
      end

      it 'updates coach profile and redirects to profile path' do
        patch :update_profile, params: { coach: valid_action_params }

        expect(response).to redirect_to(coaches_profile_path)
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
        patch :update_profile, params: { coach: invalid_action_params }

        expect(response).to render_template('profile')
        expect(assigns(:errors)).to be_present
      end
    end
  end

  describe 'coach_params' do
    it "permits specific attributes" do
      params = ActionController::Parameters.new(coach: { first_name: 'John', last_name: 'Doe', age: 25, avatar: 'avatar.jpg' })
      allow(controller).to receive(:params).and_return(params)

      expect(controller.send(:coach_params)).to eq({ "first_name" => "John", "last_name" => "Doe", "age" => 25, "avatar" => "avatar.jpg" })
    end
  end

  describe 'PATCH #update_password' do
    context 'when valid params are provided' do
      let(:valid_action_params) do
        {
          user: coach_1,
          old_password: 'example_password',
          new_password: '1234',
          new_password_confirmation: '1234'
        }
      end

      it 'updates user password and redirects to dashboard' do

        patch :update_password, params: valid_action_params

        expect(response).to redirect_to(coaches_dashboard_path)
      end
    end
  end

  describe 'GET #my_users' do
    before do
      [user_1, user_2].each { |user| user.reload }
    end

    it 'should show all coach users' do
      get :my_users

      expect(coach_1.users.size).to eq(2)
    end
  end

  describe 'GET #waiting_for_confirmation' do
    before do
      [user_coach_invitation_1, user_coach_invitation_2].each { |inv| inv.reload }
    end

    it 'should return all unaccepted invitations' do
      get :waiting_for_confirmation
      expect(UsersCoachesInvitation.count).to eq(2)
      expect(coach_1.users_coaches_invitations.where(accepted: nil).count).to eq(2)
    end
  end

  describe 'POST #accept_invite' do
    before do
      allow(controller).to receive(:current_coach).and_return(coach_1)
    end

    context 'when the service call is successful' do
      before do
        allow(Coaches::AcceptInviteService).to receive(:new).and_return(instance_double(Coaches::AcceptInviteService, call: true))
        post :accept_invite, params: { invitation_id: user_coach_invitation_1.id }
      end

      it 'redirects to waiting_for_confirmation_path and sets a success flash message' do
        expect(response).to redirect_to(coaches_waiting_for_confirmation_path)
        expect(flash[:success]).to eq('You`ve assigned user!')
      end
    end
  end

  describe 'POST #decline_invite' do
    it 'should decline_invite', :example do
      patch :decline_invite, params: { invitation_id: user_coach_invitation_2.id }
      user_coach_invitation_2.reload
      expect(user_coach_invitation_2.accepted).to eq(false)
      expect(response).to redirect_to(coaches_waiting_for_confirmation_path)
    end
  end
end
