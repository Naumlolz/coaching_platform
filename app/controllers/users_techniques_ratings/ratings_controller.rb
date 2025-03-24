# users_techniques_ratings controller
class UsersTechniquesRatings::RatingsController < ApplicationController
  def create
    @rating = UsersTechniquesRating.find_or_initialize_rating(
      user_id: current_user.id,
      technique_id: params[:technique_id]
    )

    rate_value = params[:rate]

    if @rating.new_record?
      save_new_rating(rating: @rating, rate: rate_value)
    else
      update_existing_rating(rating: @rating, rate: rate_value)
    end
  rescue ActiveRecord::RecordInvalid => validation_error
    flash[:alert] = validation_error.message
  ensure
    redirect_to user_techniques_path
  end

  private

  def save_new_rating(rating:, rate:)
    rating.save_with_notification(rate: rate, user_id: rating.user_id, technique_id: rating.technique_id)
    flash.now[:notice] = t('flash.ratings.created')
  end

  def update_existing_rating(rating:, rate:)
    rating.update!(rate: rate)
    flash.now[:notice] = t('flash.ratings.updated')
  end
end
