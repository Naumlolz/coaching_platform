require 'rails_helper'

RSpec.describe Technique, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:program_id) }
  end

  describe 'associations' do
    it { should belong_to(:program) }
    it { should have_many(:users_techniques) }
    it { should have_many(:users).through(:users_techniques) }
    it { should have_many(:users_techniques_ratings) }
    it { should have_many(:steps).dependent(:destroy) }
    it { should have_many(:user_completed_steps) }
  end

  describe 'schema' do
    it { should have_db_column(:name) }
    it { should have_db_column(:description) }
    it { should have_db_column(:program_id) }
  end
end
