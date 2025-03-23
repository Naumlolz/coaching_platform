require 'rails_helper'

RSpec.describe UsersTechniquesTime, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'schema' do
    it { should have_db_column(:user_id) }
    it { should have_db_column(:total_time_spent) }
  end
end
