module ControllerMacros
  def login_user
    before(:each) do
      @user = FactoryBot.create(:user)
      request.session[:member_type] = 'User'
      request.session[:member_id] = @user.id
    end
  end

  def login_coach
    before(:each) do
      @coach = FactoryBot.create(:coach)
      request.session[:member_type] = 'Coach'
      request.session[:member_id] = @coach.id
    end
  end
end
