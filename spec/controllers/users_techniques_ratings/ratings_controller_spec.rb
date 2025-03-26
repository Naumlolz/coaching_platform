require 'rails_helper'

RSpec.describe UsersTechniquesRatings::RatingsController, type: :controller do
  let(:user) { create(:user) }
  let(:technique) { create(:technique) }
  let(:valid_rate) { 'like' }
  let(:invalid_rate) { 6 }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'POST #create' do
    context 'with valid params' do
      context 'when rating does not exist' do
        it 'creates a new rating' do
          expect {
            post :create, params: { technique_id: technique.id, rate: valid_rate }
          }.to change(UsersTechniquesRating, :count).by(1)
        end

        it 'calls save_with_notification' do
          expect_any_instance_of(UsersTechniquesRating).to receive(:save_with_notification)
            .with(rate: valid_rate, user_id: user.id, technique_id: technique.id)
          post :create, params: { technique_id: technique.id, rate: valid_rate }
        end

        it 'sets flash notice' do
          post :create, params: { technique_id: technique.id, rate: valid_rate }
          expect(flash[:notice]).to eq(I18n.t('flash.ratings.created'))
        end
      end

      context 'when rating already exists' do
        let!(:existing_rating) do
          create(:users_techniques_rating, 
                  user: user, 
                  technique: technique, 
                  rate: 'dislike')
        end

        it 'updates existing rating' do
          post :create, params: { technique_id: technique.id, rate: valid_rate }
          expect(existing_rating.reload.rate).to eq(valid_rate)
        end

        it 'sets flash notice' do
          post :create, params: { technique_id: technique.id, rate: valid_rate }
          expect(flash[:notice]).to eq(I18n.t('flash.ratings.updated'))
        end

        it 'does not create new rating' do
          expect {
            post :create, params: { technique_id: technique.id, rate: valid_rate }
          }.not_to change(UsersTechniquesRating, :count)
        end
      end
    end

    context 'with invalid params' do
      it 'sets flash alert when record is invalid' do
        allow_any_instance_of(UsersTechniquesRating).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
        post :create, params: { technique_id: technique.id, rate: invalid_rate }
        expect(flash[:alert]).to be_present
      end

      it 'redirects to user_techniques_path when error occurs' do
        allow_any_instance_of(UsersTechniquesRating).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
        post :create, params: { technique_id: technique.id, rate: invalid_rate }
        expect(response).to redirect_to(user_techniques_path)
      end
    end

    it 'always redirects to user_techniques_path' do
      post :create, params: { technique_id: technique.id, rate: valid_rate }
      expect(response).to redirect_to(user_techniques_path)
    end
  end
end
