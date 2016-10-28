class CreateRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :regions do |t|
      t.integer :region_identifier # -> id
      t.string :api_url # -> obaBaseUrl
      t.string :web_url
      t.string :name # -> regionName
    end
    add_index :regions, :region_identifier, unique: true
  end
end