class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.text :title
      t.text :img_src

      t.timestamps
    end
  end
end
