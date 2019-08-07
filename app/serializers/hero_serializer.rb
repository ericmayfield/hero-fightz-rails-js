class HeroSerializer < ActiveModel::Serializer
  attributes :id, :name, :battle_cry, :bio, :img_path
  belongs_to :user
end
