class AddLongitudeToTips < ActiveRecord::Migration
  def change
    add_column :tips, :longitude, :float
  end
end
