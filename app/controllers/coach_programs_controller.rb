# list of current coach programs
class CoachProgramsController < ApplicationController
  def index
    @coach_programs = CoachesProgram.where(coach_id: current_coach.id).includes(program: [:techniques])
  end
end
