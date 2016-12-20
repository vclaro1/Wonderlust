class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :sex, :string
  end
end
