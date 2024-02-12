require 'rails_helper'

RSpec.describe CoachesProgram, type: :model do
  describe 'associations' do
    it { should belong_to(:coach) }
    it { should belong_to(:program) }
  end

  describe 'schema' do
    it { should have_db_column(:coach_id) }
    it { should have_db_column(:program_id) }
  end
end
