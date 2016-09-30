class RemoveTransportIdFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :transport_id, :integer
  end
end
