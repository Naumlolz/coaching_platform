require 'rails_helper'

RSpec.describe Users::ChooseProgramService do
  describe '#perform' do
    let(:user_1) { create(:user) }
    let(:program_1) { create(:program) }
    let(:existing_technique) { create(:technique, program_id: program_1.id) }
    let(:service_params) do
      {
        user: user_1,
        program_id: program_1.id
      }
    end

    before do
      create(:users_technique, user_id: user_1.id, technique_id: existing_technique.id)
      create(:technique, program_id: program_1.id)
      create(:technique, program_id: program_1.id)
    end

    it 'updates user program_id and creates user techniques' do
      service = described_class.new(service_params)
      expect { service.perform }.to change { UsersTechnique.where(user_id: user_1.id).count }.by(2)
      expect(user_1.reload.program_id).to eq(program_1.id)
    end

    it 'skips creating existing user techniques' do
      service = described_class.new(service_params)
      expect { service.perform }.to change { UsersTechnique.where(user_id: user_1.id, technique_id: existing_technique.id).count }.by(0)
    end
  end
end
