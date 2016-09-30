class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
