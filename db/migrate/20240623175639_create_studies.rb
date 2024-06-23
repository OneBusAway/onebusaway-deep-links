class CreateStudies < ActiveRecord::Migration[7.1]
  def change
    create_table :studies do |t|
      t.string :name
      t.text :description
      t.references :region, null: false, foreign_key: true
      t.jsonb :extra_data, default: {}
      t.timestamps
    end
  end
end
