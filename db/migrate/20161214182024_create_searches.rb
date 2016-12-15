class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :name
      t.string :interests
      t.string :continent

      t.timestamps null: false
    end
  end
end
