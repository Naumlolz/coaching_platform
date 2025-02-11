class UserTechniquesController < ApplicationController
  def index
    @users_techniques = UsersTechnique.where(user_id: current_user.id).sorted_by_progress
  end
end
