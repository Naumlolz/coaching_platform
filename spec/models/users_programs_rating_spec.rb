require 'rails_helper'

RSpec.describe UsersProgramsRating, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:rating_type) }
    it { should validate_inclusion_of(:rating_type).in_array(%w[like dislike]) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:program) }
  end

  describe 'schema' do
    it { should have_db_column(:user_id) }
    it { should have_db_column(:rating_type) }
    it { should have_db_column(:program_id) }
  end
end
