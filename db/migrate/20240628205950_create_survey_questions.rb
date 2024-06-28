class CreateSurveyQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_questions do |t|
      t.references :study_invite, null: false, foreign_key: true
      t.jsonb :content, null: false, default: {}
      t.integer :position, null: false
      t.index :position
      t.index [:study_invite_id, :position], unique: true
      t.timestamps
    end
  end
end
