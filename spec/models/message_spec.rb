require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:coach_id) }
    it { should validate_inclusion_of(:sent_by_coach).in_array([true, false]) }
  end

  describe 'associations' do
    it { should belong_to(:user).optional }
    it { should belong_to(:coach) }
  end

  describe 'schema' do
    it { should have_db_column(:coach_id) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:sent_by_coach) }
    it { should have_db_column(:body) }
  end
end
