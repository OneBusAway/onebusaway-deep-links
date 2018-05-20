class AddBoundsToRegions < ActiveRecord::Migration[5.1]
  def change
    add_column :regions, :bounds_list, :jsonb, null: false, default: '[]'
  end
end