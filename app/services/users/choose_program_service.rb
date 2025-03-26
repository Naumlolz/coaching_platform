# user choose program logic
class Users::ChooseProgramService
  def initialize(params)
    @user = params[:user]
    @program_id = params[:program_id]
    @technique_ids = fetch_technique_ids
  end

  def perform
    update_program_id
    create_user_techniques
  end

  private

  attr_reader :user, :program_id

  def update_program_id
    user.update(program_id: program_id)
  end

  def create_user_techniques
    techniques = Technique.where(program_id: program_id)
    techniques.each do |technique|
      technique_id = technique.id
      next if @technique_ids.include?(technique_id)

      UsersTechnique.create(
        user_id: user.id, technique_id: technique_id
      )
    end
  end

  def fetch_technique_ids
    UsersTechnique.where(user_id: user.id).pluck(:technique_id)
  end
end
