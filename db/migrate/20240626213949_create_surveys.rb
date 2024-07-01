class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.references :study, null: false, foreign_key: true
      t.boolean :available, default: true
      t.index :available
      t.jsonb :extra_data, default: {}

      t.timestamps
    end
  end
end
