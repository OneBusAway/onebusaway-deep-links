class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.references :survey, null: false, foreign_key: true
      t.jsonb :content, null: false, default: {}
      t.integer :position, null: false
      t.index :position
      t.index [:survey_id, :position], unique: true
      t.timestamps
    end
  end
end
