require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    # it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
  end

  describe 'associations' do
    it { should have_one_attached(:avatar) }
    it { should belong_to(:coach).optional }
    it { should belong_to(:program).optional }
    it { should have_many(:users_techniques) }
    it { should have_many(:techniques).through(:users_techniques) }
    it { should have_many(:users_techniques_ratings) }
    it { should have_many(:users_coaches_invitations) }
    it { should have_many(:user_completed_steps) }
    it { should have_many(:steps).through(:user_completed_steps) }
    it { should have_many(:messages).dependent(:destroy) }
  end

  describe 'schema' do
    it { should have_db_column(:first_name) }
    it { should have_db_column(:last_name) }
    it { should have_db_column(:age) }
    it { should have_db_column(:description) }
    it { should have_db_column(:gender) }
    it { should have_db_column(:email) }
    it { should have_db_column(:password) }
    it { should have_db_column(:coach_id) }
    it { should have_db_column(:program_id) }
    it { should have_db_column(:reset_password_code) }
    it { should have_db_column(:reset_password_code_sent_at) }
  end
end
