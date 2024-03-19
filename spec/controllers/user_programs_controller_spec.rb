require 'rails_helper'

RSpec.describe UserProgramsController, type: :controller do
  login_user

  let(:user_1) { create(:user, coach_id: coach_1.id, program_id: coach_1.programs.ids.first) }
  let(:coach_1) { create(:coach) }
  
  let(:program_1) { create(:program) }
  let(:controller_params) do
    {
      user: user_1,
      program_id: coach_1.programs.ids.last
    }
  end

  subject { Users::ChooseProgramService.new(controller_params) }

  describe 'GET #index' do
    it 'renders coaches programs and current chosen program' do
      get :index
      expect(coach_1.programs.pluck(:id)).to eq(user_1.coach.programs.pluck(:id))

      expect(coach_1.programs.ids).to include(user_1.program_id)
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT #update' do
    it 'updates users program' do
      subject.perform
      put :update, params: { id: user_1.program_id }

      expect(user_1.program_id).to eq(controller_params[:program_id])
      expect(flash[:success]).to eq('The program is chosen')
      expect(response).to redirect_to(users_dashboard_path)
    end
  end
end
