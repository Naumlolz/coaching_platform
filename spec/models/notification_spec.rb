require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:message) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:coach) }
  end

  describe 'schema' do
    it { should have_db_column(:user_id) }
    it { should have_db_column(:coach_id) }
    it { should have_db_column(:message) }
    it { should have_db_column(:read) }
    it { should have_db_column(:on_click_url) }
    it { should have_db_column(:to_user) }
  end
end
