class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.date :check_in, null: false
      t.date :check_out, null: false
      t.integer :guests, null: false
      t.datetime :confirmed_at

      t.timestamps
    end

    add_index :reservations, [:room_id, :check_in]
  end
end
