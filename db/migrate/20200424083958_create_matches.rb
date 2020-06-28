class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :round_of_tournament
      t.datetime :date
      t.timestamps
    end
  end
end
