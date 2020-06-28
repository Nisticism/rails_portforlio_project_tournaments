class CreateTournaments < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.datetime :start_date
      t.integer :prize_pool
      t.timestamps
    end
  end
end
