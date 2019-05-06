class CreateHeros < ActiveRecord::Migration[5.2]
  def change
    create_table :heros do |t|
      t.text :name
      t.text :battle_cry
      t.text :bio
      t.text :img_path
      t.integer :hero_mp
      t.integer :hero_hp
      t.integer :hero_atk
      t.integer :hero_def
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
