class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  mount_uploader :image, ImageUploader

  has_and_belongs_to_many :championships
  has_and_belongs_to_many :teams

  def team_in_championship(championship)
    teams.find_by(championship_id: championship.id)
  end

  def leave_team(team_id)
    team = teams.find_by(id: team_id)
    if team.present?
      team.users.delete(self)
      if team.users.empty?
        team.destroy
      end
      true
    else
      false
    end
  end
  
end
