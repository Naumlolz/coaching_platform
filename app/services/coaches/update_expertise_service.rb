class Coaches::UpdateExpertiseService
  def initialize(params)
    @coach_id = params[:coach_id]
    @program_ids = params[:program_ids]
  end
  
  def perform
    destroy_expertise
    create_expertise
  end

  private

  def destroy_expertise
    CoachesProgram.where(coach_id: @coach_id).destroy_all
  end

  def create_expertise
    @program_ids.each do |program_id|
      CoachesProgram.create(coach_id: @coach_id, program_id: program_id)
    end
  end
end