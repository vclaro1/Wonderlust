class AddTravelModeToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :travel_mode, :string
  end
end
