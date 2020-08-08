class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title
      t.datetime :release_date
      t.string :genre
      
      t.timestamps null: false
    end
  end
end
