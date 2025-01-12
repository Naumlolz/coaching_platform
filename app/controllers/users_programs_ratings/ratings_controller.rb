class UsersProgramsRatings::RatingsController < ApplicationController
  def create
    @rating = UsersProgramsRating.find_or_initialize_by(user_id: current_user.id, program_id: params[:program_id])

    if @rating.new_record?
      @rating.rating_type = params[:rating_type]
      @rating.save!
      flash[:notice] = t('flash.ratings.created')
    else
      @rating.update!(rating_type: params[:rating_type])
      flash[:notice] = t('flash.ratings.updated')
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.message
  ensure
    redirect_to user_techniques_path
  end
end
