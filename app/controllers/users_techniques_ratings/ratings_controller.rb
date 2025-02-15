class UsersTechniquesRatings::RatingsController < ApplicationController
  def create
    @rating = UsersTechniquesRating.find_or_initialize_by(
      user_id: current_user.id, technique_id: params[:technique_id]
    )

    if @rating.new_record?
      @rating.rate = params[:rate]
      @rating.save!

      Notifications::TechniqueRateNotificationWorker.perform_async(current_user.id, params[:technique_id], params[:rate])

      flash[:notice] = t('flash.ratings.created')
    else
      @rating.update!(rate: params[:rate])
      flash[:notice] = t('flash.ratings.updated')
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.message
  ensure
    redirect_to user_techniques_path
  end
end
