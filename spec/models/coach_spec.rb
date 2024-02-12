require 'rails_helper'

RSpec.describe Coach, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:email) }
    # it { should validate_uniqueness_of(:email).scoped_to(:coach_id) }
  end

  describe 'associations' do
    it { should have_one_attached(:avatar) }
    it { should have_many(:users) }
    it { should have_many(:users_coaches_invitations) }
    it { should have_many(:coaches_programs) }
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_many(:programs).through(:coaches_programs) }
  end

  describe 'schema' do
    it { should have_db_column(:first_name) }
    it { should have_db_column(:last_name) }
    it { should have_db_column(:description) }
    it { should have_db_column(:age) }
    it { should have_db_column(:gender) }
    it { should have_db_column(:email) }
    it { should have_db_column(:password) }
    it { should have_db_column(:experience) }
    it { should have_db_column(:education) }
    it { should have_db_column(:certificate) }
  end
end
