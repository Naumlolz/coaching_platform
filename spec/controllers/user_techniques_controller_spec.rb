require 'rails_helper'

RSpec.describe UserTechniquesController, type: :controller do
  login_user
  let(:users_technique_1) { create(:users_technique) }

  describe 'GET #index' do
    it 'renders the index page' do
      users_technique_1
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
    end
  end
end