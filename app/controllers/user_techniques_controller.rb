class UserTechniquesController < ApplicationController
  def index
    @users_techniques = UsersTechnique.where(user_id: current_user.id)
  end
end