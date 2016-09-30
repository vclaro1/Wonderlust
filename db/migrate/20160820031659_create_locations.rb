class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.decimal :lat, :precision => 15, :scale => 13
      t.decimal :long, :precision => 15, :scale => 13
      t.integer :trip_id
      t.integer :days
      t.integer :order
      t.integer :transport_id

      t.timestamps null: false
    end
  end
end
