class CreateSurveyResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_responses do |t|
      t.references :survey, null: false, foreign_key: true
      t.string :user_identifier, null: false
      t.index :user_identifier
      t.string :public_identifier, null: false
      t.index :public_identifier, unique: true
      t.jsonb :responses, null: false, default: {}
      t.timestamps
    end
  end
end
