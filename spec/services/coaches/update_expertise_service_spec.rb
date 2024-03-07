require 'rails_helper'

RSpec.describe Coaches::UpdateExpertiseService do
  let(:coach_1) { create(:coach) }
  let(:program_1) { create(:program) }
  let(:program_2) { create(:program) }
  let(:coaches_program) { create(:coaches_program, coach_id: coach_1.id) }
  let(:service_params) do
    {
      coach_id: coach_1.id,
      program_ids: [program_1.id, program_2.id]
    }
  end

  subject { described_class.new(service_params) }

  describe '#perform' do
    it 'destroys existing expertise and creates new expertise' do
      expect(subject).to receive(:destroy_expertise)
      expect(subject).to receive(:create_expertise)
      subject.perform
    end
  end

  describe '#destroy_expertise' do
    it 'should destroy expertise for the coach' do
      expect(CoachesProgram).to receive(:where).with(coach_id: coach_1.id).and_return(double(destroy_all: true))
      subject.send(:destroy_expertise)
    end
  end

  describe '#create_expertise' do
    it 'creates CoachesProgram records for each program id' do
      service_params[:program_ids].each do |program_id|
        expect(CoachesProgram).to receive(:create).with(coach_id: coach_1.id, program_id: program_id)
      end
      subject.send(:create_expertise)
    end
  end
end
