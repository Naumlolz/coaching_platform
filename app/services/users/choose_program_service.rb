class Users::ChooseProgramService
  def initialize(user, program_id)
    @user = user
    @program_id = program_id
    @technique_ids = fetch_technique_ids
  end

  def perform
    update_program_id
    create_user_techniques
  end

  private

  def update_program_id
    @user.update(program_id: @program_id)
  end

  def create_user_techniques
    techniques = Technique.where(program_id: @program_id)
    techniques.each do |technique|
      next if @technique_ids.include?(technique.id)
      UsersTechnique.create(
        user_id: @user.id, technique_id: technique.id
      )
    end
  end

  def fetch_technique_ids
    UsersTechnique.where(user_id: @user.id).pluck(:technique_id)
  end
end