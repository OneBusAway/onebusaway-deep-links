class AddRequiredToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :required, :boolean, default: true
  end
end
