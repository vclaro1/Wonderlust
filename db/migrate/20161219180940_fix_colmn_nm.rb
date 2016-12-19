class FixColmnNm < ActiveRecord::Migration
  def change
  	rename_column :searches, :type, :tipo
  end
end
