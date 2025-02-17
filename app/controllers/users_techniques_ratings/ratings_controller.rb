class UsersTechniquesRatings::RatingsController < ApplicationController
  def create
    @rating = find_or_initialize_rating(user_id: current_user.id, technique_id: params[:technique_id])

    if @rating.new_record?
      save_new_rating(rating: @rating, rate: params[:rate])
    else
      update_existing_rating(rating: @rating, rate: params[:rate])
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.message
  ensure
    redirect_to user_techniques_path
  end

  private

  def find_or_initialize_rating(user_id:, technique_id:)
    UsersTechniquesRating.find_or_initialize_by(
      user_id: user_id,
      technique_id: technique_id
    )
  end

  def save_new_rating(rating:, rate:)
    rating.rate = rate
    rating.save!
    enqueue_notification(user_id: rating.user_id, technique_id: rating.technique_id, rate: rate)
    flash.now[:notice] = t('flash.ratings.created')
  end

  def update_existing_rating(rating:, rate:)
    rating.update!(rate: rate)
    flash.now[:notice] = t('flash.ratings.updated')
  end

  def enqueue_notification(user_id:, technique_id:, rate:)
    Notifications::TechniqueRateNotificationWorker.perform_async(
      user_id: user_id,
      technique_id: technique_id,
      rate: rate
    )
  end
end
