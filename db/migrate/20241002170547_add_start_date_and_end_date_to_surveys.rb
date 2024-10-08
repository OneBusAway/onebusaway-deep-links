class AddStartDateAndEndDateToSurveys < ActiveRecord::Migration[7.1]
  def change
    add_column :surveys, :start_date, :datetime
    add_column :surveys, :end_date, :datetime
  end
end
