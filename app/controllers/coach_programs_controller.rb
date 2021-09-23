class CoachProgramsController < ApplicationController
  def index
    @coach_programs = CoachesProgram.where(coach_id: current_coach.id)
  end
end