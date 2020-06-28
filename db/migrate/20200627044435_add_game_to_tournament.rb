class AddGameToTournament < ActiveRecord::Migration[5.0]
  def change
    add_reference :tournaments, :game, index: true, foreign_key: true
  end
end
