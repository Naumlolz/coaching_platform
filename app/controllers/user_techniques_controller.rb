class UserTechniquesController < ApplicationController
  def index
    @users_techniques = UsersTechnique.where(user_id: current_user.id)
                                      .left_joins(:user_completed_steps)
                                      .group(:id)
                                      .order(Arel.sql('COUNT(user_completed_steps.id) DESC NULLS LAST'))
  end
end
