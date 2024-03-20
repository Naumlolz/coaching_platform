require 'rails_helper'

RSpec.describe StepsController, type: :controller do
  let(:step_1) { create(:step, technique_id: technique_1.id, position: 0) }
  let(:step_2) { create(:step, technique_id: technique_1.id, position: 1) }
  let(:user_1) { create(:user) }
  let(:technique_1) { create(:technique) }

  describe '#show' do
    it 'shows step and current technique' do
      get :show, params: { id: step_1.id }

      expect(assigns(:step)).to eq(step_1)
      expect(assigns(:current_technique)).to eq(technique_1)
    end
  end

  describe '#perform_complete' do
    before do
      allow(controller).to receive(:current_user).and_return(user_1)
    end

    it 'redirects to the next step path when next step exists' do
      service = instance_double(Users::RecordCompletedStepService, perform: 123)
      allow(Users::RecordCompletedStepService).to receive(:new).and_return(service)
      post :perform_complete, params: { technique_id: 456, id: 789 }

      expect(response).to redirect_to(step_path(123))
    end

    it 'redirects to user_techniques_path when next step does not exist' do
      service = instance_double(Users::RecordCompletedStepService, perform: nil)
      allow(Users::RecordCompletedStepService).to receive(:new).and_return(service)

      post :perform_complete, params: { technique_id: 456, id: 789 }

      expect(response).to redirect_to(user_techniques_path)
    end
  end
end