class AddDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dob, :date
    add_column :users, :trips_count, :integer
  end
end
