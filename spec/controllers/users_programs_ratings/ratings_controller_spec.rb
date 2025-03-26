require 'rails_helper'

RSpec.describe UsersProgramsRatings::RatingsController, type: :controller do
  let(:user) { create(:user) }
  let(:program) { create(:program) }
  let(:valid_rating_type) { 'like' }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'POST #create' do
    context 'with valid params' do
      context 'when rating does not exist' do
        it 'creates a new rating' do
          expect {
            post :create, params: { program_id: program.id, rating_type: valid_rating_type }
          }.to change(UsersProgramsRating, :count).by(1)
        end
      end
    end
  end
end
