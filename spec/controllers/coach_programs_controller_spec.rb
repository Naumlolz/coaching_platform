require 'rails_helper'

RSpec.describe CoachProgramsController, type: :controller do
  login_coach
  let(:coaches_program_1) { create(:coaches_program) }

  describe 'GET #index' do
    it 'renders the index page' do
      coaches_program_1
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
    end
  end
end
