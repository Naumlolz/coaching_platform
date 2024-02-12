require 'rails_helper'

RSpec.describe UserCompletedStep, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:step_id) }
    it { should validate_presence_of(:technique_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:step) }
    it { should belong_to(:technique) }
  end

  describe 'schema' do
    it { should have_db_column(:user_id) }
    it { should have_db_column(:step_id) }
    it { should have_db_column(:technique_id) }
  end
end
