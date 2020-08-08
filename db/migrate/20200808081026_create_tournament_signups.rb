class CreateTournamentSignups < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_signups do |t|

      t.integer :player_id
      t.integer :tournament_id

      t.timestamps null: false
    end
  end
end
