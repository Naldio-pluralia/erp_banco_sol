class AddOptionToQuestionOptions < ActiveRecord::Migration[5.1]
  def change
    add_column :question_options, :option, :text, null: false
  end
end
