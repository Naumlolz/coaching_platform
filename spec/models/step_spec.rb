require 'rails_helper'

RSpec.describe Step, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:technique_id) }
    it { should validate_presence_of(:position) }
  end

  describe 'associations' do
    it { should belong_to(:technique) }
    it { should have_many(:user_completed_steps) }
  end

  describe 'schema' do
    it { should have_db_column(:title) }
    it { should have_db_column(:body) }
    it { should have_db_column(:technique_id) }
    it { should have_db_column(:position) }
  end
end
