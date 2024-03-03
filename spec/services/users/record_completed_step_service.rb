require 'rails_helper'

RSpec.describe Users::RecordCompletedStepService do
  let(:user_1) { create(:user) }
  let(:technique_1) { create(:technique) }
  let(:step_1) { create(:step, technique_id: technique_1.id) }
  let(:service_params) do
    {
      user_id: user_1.id,
      technique_id: technique_1.id,
      step_id: step_1.id
    }
  end
  # let(:next_step) { create(:step, technique_id: technique_1.id, position: 2) }

  describe '#check_step_validity' do
    context 'when params are valid' do
      it 'should find step by id' do
        expect(Step.find_by(id: step_1.id)).to eq(step_1)
      end
    end

    context 'when step_id invalid' do
      it 'should raise error' do
        expect do
          described_class.new(
            service_params.merge(step_id: -1)
          ).perform
        end.to raise_error(ServiceError, 'Validity error')
      end
    end
  end

  describe '#create_completed_step' do
    it 'should create completed step' do
      expect(UserCompletedStep.count).to eq(0)

      expect do
        described_class.new(service_params).perform
      end.to change(UserCompletedStep, :count).by(1)
    end
  end

  describe '#search_for_next_step' do
    it 'should find next step' do
      next_step = create(:step, technique_id: technique_1.id, position: 2)
      service = described_class.new(service_params).perform
      expect(service).to eq(next_step.id)
    end
  end
end
