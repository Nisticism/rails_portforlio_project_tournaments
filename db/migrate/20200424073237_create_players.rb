class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.String :name
      t.String :email
      t.String :password

      t.timestamps
    end
  end
end
