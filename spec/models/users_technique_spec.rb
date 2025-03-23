require 'rails_helper'

RSpec.describe UsersTechnique, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:technique_id) }
    it { should validate_presence_of(:technique_status) }
    it { should validate_inclusion_of(:technique_status).in_array(%w[not_started in_progress completed]) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:technique) }
  end

  describe 'schema' do
    it { should have_db_column(:user_id) }
    it { should have_db_column(:technique_id) }
    it { should have_db_column(:technique_status) }
  end
end
