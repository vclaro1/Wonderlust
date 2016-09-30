class AddMagicToTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :spent
  end
end
