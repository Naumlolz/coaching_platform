require 'rails_helper'

RSpec.describe Program, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should have_many(:techniques).dependent(:destroy) }
    it { should have_many(:users) }
    it { should have_many(:coaches_programs) }
    it { should have_many(:coaches).through(:coaches_programs) }
  end

  describe 'schema' do
    it { should have_db_column(:name) }
    it { should have_db_column(:description) }
  end
end
