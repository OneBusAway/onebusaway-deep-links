class AddStopIdentifierToSurveyResponses < ActiveRecord::Migration[7.1]
  def change
    add_column :survey_responses, :stop_identifier, :string
    add_index :survey_responses, :stop_identifier
  end
end
