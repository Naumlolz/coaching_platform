require 'rails_helper'

RSpec.describe Users::RestartStepService do
  let(:user_1) { create(:user) }
  let(:technique_1) { create(:technique) }
  let(:service_params) do
    {
      user_id: user_1.id,
      technique_id: technique_1.id
    }
  end

  it 'should destroy all completed steps and return first step' do
    create(:user_completed_step, user_id: user_1.id, technique_id: technique_1.id, step: create(:step, technique: technique_1, position: 1))
    create(:user_completed_step, user_id: user_1.id, technique_id: technique_1.id, step: create(:step, technique: technique_1, position: 2))

    expect do
      described_class.new(service_params).perform
    end.to change(UserCompletedStep, :count).by(-2)

    first_step = create(:step, technique_id: technique_1.id, position: 0)
    expect(described_class.new(service_params).perform).to eq(first_step.id)
  end
end
