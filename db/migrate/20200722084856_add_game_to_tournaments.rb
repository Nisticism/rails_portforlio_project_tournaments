class AddGameToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_reference :tournaments, :game, foreign_key: true
  end
end
