class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :description
      t.datetime :date
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
