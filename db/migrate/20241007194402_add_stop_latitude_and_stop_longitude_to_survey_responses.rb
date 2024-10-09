class AddStopLatitudeAndStopLongitudeToSurveyResponses < ActiveRecord::Migration[7.1]
  def change
    add_column :survey_responses, :stop_latitude, :decimal, precision: 15, scale: 10
    add_column :survey_responses, :stop_longitude, :decimal, precision: 15, scale: 10
  end
end
