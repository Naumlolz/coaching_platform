class CoachesController < ApplicationController
  def dashboard
    redirect_to coaches_finish_profile_path if current_coach.age.blank?
  end

  def finish_profile
  end

  def finish_coach_profile
    coach = current_coach
    coach.update(
      age: params[:age],
      gender: params[:gender],
      description: params[:description],
      expertise: params[:expertise],
      education: params[:education],
      experience: params[:experience],
      certificate: params[:certificate],
    )
    redirect_to coaches_dashboard_path
  end
end