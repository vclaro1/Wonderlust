class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.string :name
      t.datetime :date_start
      t.datetime :date_end
      t.integer :rating
      t.decimal :budget
      t.decimal :spent

      t.timestamps null: false
    end
  end
end
