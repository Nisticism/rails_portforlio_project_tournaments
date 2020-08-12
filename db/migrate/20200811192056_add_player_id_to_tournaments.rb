class AddPlayerIdToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_reference :tournaments, :player, foreign_key: true
  end
end
