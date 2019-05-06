class Hero < ApplicationRecord
  belongs_to :user
  belongs_to :team, optional: true

  validates :name, format: { without: /[0-9]/, message: "does not allow numbers" }, presence: true
  validates :battle_cry, presence: true
  validates :bio, presence: true
  validates :img_path, presence: true

  # Scope to load the last five heroes created
  def self.last_four_heros
    order(id: :desc).limit(4)
  end

  # Scope method to load heros by team id
  def self.heros_by_team_id(team_id)
    where(team_id: team_id)
  end

end
