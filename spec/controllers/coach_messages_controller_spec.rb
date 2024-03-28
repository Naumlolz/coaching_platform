require 'rails_helper'

RSpec.describe CoachMessagesController, type: :controller do
  let(:coach) { create(:coach) }
  let(:user) { create(:user) }
  let(:message1) { create(:message, coach: coach, user: user) }
  let(:message2) { create(:message, coach: coach, user: user) }

  before do
    allow(controller).to receive(:current_coach) { coach }
    get :index, params: { user_id: user.id }
  end

  describe 'GET #index' do
    it 'assigns @user_id' do
      expect(assigns(:user_id).to_i).to eq(user.id)
    end

    it 'assigns @messages' do
      expect(assigns(:messages)).to match_array([message1, message2])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    it 'creates a new message' do
      expect {
        post :create, params: { body: "Test message body", user_id: user.id }, session: { current_coach_id: coach.id }
      }.to change(Message, :count).by(1)
      expect(response).to redirect_to(coach_messages_path(user_id: user.id))
    end
  end
end
