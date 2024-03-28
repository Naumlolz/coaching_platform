require 'rails_helper'

RSpec.describe UserMessagesController, type: :controller do
  let(:user_1) { create(:user) }
  let(:message_1) { create(:message, user_id: user_1.id, coach_id: user_1.coach_id) }
  let(:message_2) { create(:message, user_id: user_1.id, coach_id: user_1.coach_id) }

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user_1)
  end

  describe 'GET #index' do
    it 'assigns @messages' do
      get :index
      expect(assigns(:messages)).to match_array([message_1, message_2])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    it 'creates a new message' do
      expect {
        post :create, params: { body: "Test message body" }, session: { current_user_id: user_1.id }
      }.to change(Message, :count).by(1)
      expect(response).to redirect_to(user_messages_path)
    end
  end
end
