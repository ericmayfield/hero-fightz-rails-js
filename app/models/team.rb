class Team < ApplicationRecord
    has_many :heros
    has_many :users, through: :heros

    validates :title, presence: true
end
