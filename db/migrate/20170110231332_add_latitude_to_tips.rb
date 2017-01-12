class AddLatitudeToTips < ActiveRecord::Migration
  def change
    add_column :tips, :latitude, :float
  end
end
